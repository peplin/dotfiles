#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source "$SCRIPT_DIRECTORY/util.sh"

set -e

declare -A branch_parents
declare visited_branches

FORCE=""
PUSH=""
BRANCH=""

while getopts 'pfb:' flag; do
    case "${flag}" in
        p) PUSH='true' ;;
        f) FORCE='true' ;;
        b) BRANCH="${OPTARG}" ;;
        *) exit 1 ;;
    esac
done

# Switch to old school method since update-refs isn't handling rebases as cleanly
FORCE="true"

# Recursively rebase this and all child branches against their upstream branch.
flowdown() {
    local branch=$1
    local upstream
    local depth=$(($2))
    local push=$3
    local indentation=""
    for _ in $(seq 1 $depth); do
        indentation+="  "
    done

    upstream=$(git rev-parse --abbrev-ref --symbolic-full-name "$branch@{upstream}")
    visited_branches+=" $branch"

    # Use old school method when --update-refs fails due to a parent branch
    # having an amended commit.
    if [[ $depth == 0 ]] || [[ ${FORCE} == "true" ]]; then
        echo -n "${indentation}Rebasing $branch ..."
        _=$(git rebase --quiet --fork-point $upstream $branch)
        echo "done"
    fi

    local child_branches=("${branch_parents[$branch]}")
    if [ -z "$child_branches" ] || [ ${#child_branches[@]} -eq 0 ]; then
        echo -n "Rebasing $branch and updating all parent refs..."
        _=$(git rebase --update-refs "$starting_branch" "$branch")
        echo "done"
    fi

    for child_branch in $child_branches; do
        flowdown "$child_branch" "$depth+1" "$push"
    done
}

find_current_branch
find_starting_branch "$BRANCH"
build_branch_tree branch_parents
flowdown "$starting_branch" 0

if [[ ${PUSH} == "true" ]]; then
    echo "Pushing rebased branches..."
    _=$(git push origin --force-with-lease $visited_branches)
    echo "done"
fi

git checkout $current_branch
