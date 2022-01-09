#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

declare -A branch_parents
outputs=()

LIGHT_BLUE="\033[0;34m"
GREEN="\033[0;32m"
RED="\033[0;31m"
NO_COLOR="\033[0m"

print_branch_tree() {
    local branch=$1
    local depth=($2)
    depth=$((depth))

    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name $branch@{upstream})
    local siblings=(${branch_parents[$upstream]})
    local child_branches=("${branch_parents[$branch]}")

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

    local commit_message=$(git show -q --format=%s $branch)

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
    outputs+=("$prefix$branch_output	$commits_output	$pr_info	$commit_message")

    for child_branch in $child_branches; do
        print_branch_tree $child_branch $depth+1
    done
}

# Pass --fast to the script to disable calls to GitHub and print only local information
no_external_calls=0
if [[ "$1" == "--fast" ]]; then
    no_external_calls=1
fi

find_current_branch
find_starting_branch all
build_branch_tree $branch_parents
print_branch_tree $starting_branch 0

for info in "${outputs[@]}"; do
    echo -e "$info"
done | column -t -s "	" -T 4
