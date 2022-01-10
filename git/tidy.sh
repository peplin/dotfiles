#!/usr/bin/env bash

set -e

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

declare -A branch_parents

tidy() {
    local branch=$1
    local depth=$(($2))
    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name $branch@{upstream})
    calculate_commits_ahead_of_upstream $branch $upstream
    local child_branches=("${branch_parents[$branch]}")

    if [ $depth != 0 ] && [ $commits_ahead_of_upstream = 0 ]; then
        for child_branch in $child_branches; do
            REPARENT_OUTPUT=$(git branch -u "$upstream" "$child_branch")
            echo "Reparented $child_branch"
        done

        # If we're on a branch about to be deleted, switch to the parent
        current_branch=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD)
        if [ "$current_branch" = "$branch" ]; then
            CHECKOUT_OUTPUT=$(git checkout $upstream)
        fi

        DELETE_OUTPUT=$(git branch -d "$branch")
        echo "Removed empty branch $branch and reparented children"
    fi

    for child_branch in $child_branches; do
        tidy $child_branch $depth+1
    done

}

find_starting_branch "all"
build_branch_tree branch_parents

tidy $starting_branch 0
