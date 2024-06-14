#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

declare -A branch_parents
declare -A visited_branches
outputs=()

LIGHT_BLUE="\033[0;34m"
GREEN="\033[0;32m"
RED="\033[0;31m"
NO_COLOR="\033[0m"

render_branch_tree() {
    local branch=$1
    local depth=($2)
    depth=$((depth))

    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name $branch@{upstream})
    if [ -z "$upstream" ]; then
        local child_branches=""
        local silbings=""
    else
        local siblings=(${branch_parents[$upstream]})
        local child_branches=("${branch_parents[$branch]}")
    fi

    local prefix=""

    for i in $(seq 2 $depth); do
        prefix+="   "
    done

    if (( depth > 0 )); then
        if [ "$branch" = "${siblings[-1]}" ]; then
          prefix+="└─ "
      elif (( ${#siblings[@]} > 1 )); then
          prefix+="├─ "
        fi
    fi

    commits_diff=($(git rev-list --left-right --count $upstream...$branch))
    commits_ahead=$((commits_diff[1]))
    commits_behind=$((commits_diff[0]))
    local commits_output="("

    if (( commits_ahead > 0 )); then
        commits_output+="$GREEN+$commits_ahead$NO_COLOR"
    fi

    if (( commits_behind > 0 )); then
        if ((commits_ahead > 0)); then
            commits_output+=", "
        fi
        commits_output+="$RED-$commits_behind$NO_COLOR"
    fi

    if (( commits_ahead == 0 && commits_behind == 0)); then
        commits_output+="0"
    fi

    commits_output+=")"

    if (( depth > 0 )) && (( no_external_calls == 0 )); then
        set +e
        TMPFILE=$(mktemp)
        local pr_info_output=$(gh pr view $branch --json number,state,isDraft 2> $TMPFILE)
        if (( $? == 0 )); then
            local pr_number=$(echo $pr_info_output | jq .number)
            local pr_state=$(echo $pr_info_output | jq .state)
            local pr_draft=$(echo $pr_info_output | jq .isDraft)
        fi
        set -e
    fi

    pr_info=""
    if [ "$pr_draft" = "true" ]; then
        pr_info+="$LIGHT_BLUE"
    elif [ "$pr_state" = "\"OPEN\"" ]; then
        pr_info+="$GREEN"
    else
        pr_info+="$RED"
    fi

    pr_info+="$pr_number$NO_COLOR"

    branch_output="$branch$NO_COLOR"
    if [ "$branch" = "$current_branch" ]; then
        branch_output="$GREEN$branch_output"
    fi

    local max_cols=$(tput cols)
    local commit_message="	$(git show -q --format=%s $branch)"
    if [ $max_cols -lt 165 ]; then
        commit_message=""
    elif [ $max_cols -lt 180 ]; then
        # TODO be smarter, truncate the line to max
        commit_message=${commit_message:0:30}
    fi
    outputs+=("$prefix$branch_output	$commits_output	$pr_info	$commit_message")

    visited_branches[$branch]="foo"
    for child_branch in $child_branches; do
        render_branch_tree $child_branch $depth+1
    done
}

# Pass --fast to the script to disable calls to GitHub and print only local information
no_external_calls=0
if [[ "$1" == "--fast" ]]; then
    no_external_calls=1
fi


find_current_branch
find_starting_branch all
build_branch_tree branch_parents

render_branch_tree $starting_branch 0

# Render any branches not inheriting from the starting branch
all_heads=$(git for-each-ref --format='%(refname:short)' refs/heads)
while IFS= read -r branch; do
    if [ ! ${visited_branches[$branch]+nothing} ]; then
        render_branch_tree $branch 0
    fi
done <<< "$all_heads"

for info in "${outputs[@]}"; do
    echo -e "$info"
done | column -t -s "	"
