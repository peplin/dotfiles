#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

declare -A branch_parents
outputs=()

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

    if (( commits_ahead > 0 && commits_behind == 0)); then
        commits_output+="\033[0;32m+$commits_ahead\033[0m"
    elif (( commits_ahead > 0 && commits_behind > 0)); then
        commits_output+="\033[0;32m+$commits_ahead\033[0m, \033[0;31m-$commits_behind\033[0m"
    elif (( commits_ahead == 0 && commits_behind > 0)); then
        commits_output+="\033[0;31m+$commits_behind\033[0m"
    else
        commits_output+="0"
    fi
    commits_output+=")"

    outputs+=("$prefix$branch|$commits_output")

    for child_branch in $child_branches; do
        print_branch_tree $child_branch $depth+1
    done
}

find_current_branch
find_starting_branch all
build_branch_tree $branch_parents
print_branch_tree $starting_branch 0

for info in "${outputs[@]}"; do
    echo -e "$info"
done | column -t -s "|"

