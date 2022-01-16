#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

# Change the parent of a child branch and rebase it.
# Example:
#   reparent_branch <new parent> [<target branch to move>]
#
# If the second arg is not provided, uses the current branch.
reparent_branch() {
    new_parent_branch=$1
    child_branch=$2
    child_branch=${child_branch:=$current_branch}

    first_commit=$(git log @{upstream}~1..$child_branch --pretty=format:"%h" | tail -1)
    git switch $child_branch
    git branch -u $new_parent_branch
    git rebase --onto $new_parent_branch $first_commit
}

find_current_branch
reparent_branch $1 $2
