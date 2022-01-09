#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

declare -A branch_parents
outputs=()

print_branch_tree() {
    local branch=$1
    local depth=($2)
    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name $branch@{upstream})
    calculate_commits_ahead_of_upstream $branch $upstream
    local child_branches=("${branch_parents[$branch]}")
    local siblings=(${branch_parents[$upstream]})

    local prefix=""

    if [ $(($depth)) -gt 1 ]; then
        if [ "${#siblings[@]}" > 1 ]; then
            prefix+="│  "
        fi
    fi

    for i in $(seq 3 $((depth))); do
        prefix+="   "
    done

    if [ $(($depth)) -gt 0 ]; then
        if [ "$branch" = "${siblings[-1]}" ]; then
          prefix+="└─ "
        elif [ "${#siblings[@]}" > 1 ]; then
          prefix+="├─ "
        fi
    fi

    echo "$prefix$branch"
    for child_branch in $child_branches; do
        print_branch_tree $child_branch $(($depth+1))
    done
}

find_current_branch
find_starting_branch all
build_branch_tree $branch_parents
print_branch_tree $starting_branch 0

