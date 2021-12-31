#!/usr/bin/env bash

set -ex

# Change the parent of a child branch and rebase it.
# Example:
#   reparent_branch <new parent> [<target branch to move>]
#
# If the second arg is not provided, uses the current branch.
reparent_branch() {
    new_parent_branch=$1
    child_branch=$2
    current_branch=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD)
    child_branch=${child_branch:=$current_branch}

    first_commit=$(git log @{upstream}..$child_branch --pretty=format:"%h" | tail -1)
    git switch $child_branch
    git branch -u $new_parent_branch
    git rebase --onto $new_parent_branch $first_commit
}

reparent_branch $1 $2
