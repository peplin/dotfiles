#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

declare -A branch_parents
outputs=()

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
    local pretty_commit_count="(-${commits_diff[0]} +${commits_diff[1]})"

    outputs+=("$prefix$branch|$pretty_commit_count")

    for child_branch in $child_branches; do
        print_branch_tree $child_branch $depth+1
    done
}

find_current_branch
find_starting_branch all
build_branch_tree $branch_parents
print_branch_tree $starting_branch 0

for info in "${outputs[@]}"; do
    echo "$info"
done | column -t -s "|"

