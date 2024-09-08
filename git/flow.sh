#!/usr/bin/env bash
#
# amend

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

declare -A branch_parents
declare -A visited_branches

PUSH=""
BRANCH=""

while getopts 'pb:' flag; do
    case "${flag}" in
        p) PUSH='true' ;;
        b) BRANCH="${OPTARG}" ;;
        *) exit 1 ;;
    esac
done

# Recursively rebase this and all child branches against their upstream branch.
flowdown() {
    local branch=$1
    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name $branch@{upstream})
    local depth=$(($2))
    local push=$3

    visited_branches+=" $branch"

    local child_branches=("${branch_parents[$branch]}")
    if [ -z "$child_branches" ] || [ ${#child_branches[@]} -eq 0 ]; then
        echo -n "Rebasing $branch and updating all parent refs..."
        REBASE_OUTPUT=$(git rebase --update-refs $starting_branch $branch)
        echo "done"
    fi

    for child_branch in $child_branches; do
        flowdown $child_branch $depth+1 $push
    done
}

find_current_branch
find_starting_branch $BRANCH
build_branch_tree branch_parents
flowdown $starting_branch 0

if [[ ${PUSH} == "true" ]]; then
    echo -n "Pushing rebased branches..."
    PUSH_OUTPUT=$(git push origin --force-with-lease $branches)
    echo "done"
fi

git checkout $current_branch
