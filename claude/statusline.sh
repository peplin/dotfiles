#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Debug: Save the JSON to a file (uncomment to inspect)
echo "$input" | jq '.' > /tmp/claude-statusline-input.json

# Extract basic info
MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
MODEL_ID=$(echo "$input" | jq -r '.model.id // ""')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // "."')
TRANSCRIPT=$(echo "$input" | jq -r '.transcript_path // ""')

# Get git branch and check for uncommitted changes
BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null || echo "no-git")
DIRTY=""
if [ "$BRANCH" != "no-git" ]; then
    # Check if there are any uncommitted changes (staged or unstaged)
    if [ -n "$(git -C "$DIR" status --porcelain 2>/dev/null)" ]; then
        DIRTY="*"
    fi
fi

# Calculate context window usage from transcript
CONTEXT_INFO=""

# Determine context limit based on model name
# Only Sonnet 4.5 1M has 1M tokens; everything else (Opus 4, regular Sonnet 4.5, etc.) is 200K
if [[ "$MODEL" == *"1M"* ]] || [[ "$MODEL_ID" == *"1m"* ]] || [[ "$MODEL_ID" == *"1M"* ]]; then
    LIMIT=1000000  # Sonnet 4.5 1M variant
else
    LIMIT=200000   # Default: Opus 4, regular Sonnet 4.5, Claude 3.x, etc.
fi

if [ -n "$TRANSCRIPT" ] && [ -f "$TRANSCRIPT" ]; then
    # Get the most recent message with token usage (includes cumulative context)
    # The transcript is JSONL format - find last line with .message.usage
    TOTAL_TOKENS=$(tac "$TRANSCRIPT" | jq -r '
        select(.message.usage)
        | .message.usage
        | ((.input_tokens // 0) + (.cache_read_input_tokens // 0))
    ' 2>/dev/null | head -1)

    # Calculate percentage if we have valid data
    if [ -n "$TOTAL_TOKENS" ] && [ "$TOTAL_TOKENS" != "null" ] && [ "$TOTAL_TOKENS" -gt 0 ]; then
        PERCENT=$((TOTAL_TOKENS * 100 / LIMIT))
        # Format with K suffix for readability
        TOKENS_K=$((TOTAL_TOKENS / 1000))
        LIMIT_K=$((LIMIT / 1000))

        # Color code based on usage
        if [ "$PERCENT" -ge 80 ]; then
            COLOR="\033[31m"  # Red for 80%+
        elif [ "$PERCENT" -ge 50 ]; then
            COLOR="\033[33m"  # Yellow for 50-79%
        else
            COLOR="\033[32m"  # Green for <50%
        fi

        CONTEXT_INFO="${COLOR}${TOKENS_K}K/${LIMIT_K}K (${PERCENT}%)\033[0m"
    fi
fi

# Format output with colors (using ANSI codes)
# \033[36m = cyan, \033[33m = yellow, \033[32m = green, \033[31m = red, \033[0m = reset
echo -e "\033[36m[$MODEL]\033[0m \033[33m$BRANCH\033[0m\033[31m$DIRTY\033[0m ${CONTEXT_INFO}"
