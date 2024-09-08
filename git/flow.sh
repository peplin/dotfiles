#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source $SCRIPT_DIRECTORY/util.sh

set -e

declare -A branch_parents

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
    local indentation=""
    for i in $(seq 1 $depth); do
        indentation+="  "
    done

    echo -n "${indentation}Rebasing $branch ..."
    REBASE_OUTPUT=$(git rebase --quiet --fork-point $upstream $branch)
    echo "done"

    if [[ ${push} == "true" ]]; then
        echo -n "${indentation}Pushing $branch ..."
        PUSH_OUTPUT=$(git push origin --force-with-lease)
        echo "done"
    fi

    local child_branches=("${branch_parents[$branch]}")
    for child_branch in $child_branches; do
        flowdown $child_branch $depth+1 $push
    done
}

find_current_branch
find_starting_branch $BRANCH
build_branch_tree branch_parents
flowdown $starting_branch 0 $PUSH
git checkout $current_branch
