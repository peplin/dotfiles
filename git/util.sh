#!/usr/bin/env bash

# Build an associative array mapping parent branches to a space-separated list
# of their child branches.
build_branch_tree() {
    local -n branches=$1

    # Collect all local branches and their upstreams
    branches_and_upstreams=$(git for-each-ref --format='%(refname:short) %(upstream:short)' refs/heads)

    while IFS= read -r line; do
        branch_info=($line)
        branch="${branch_info[0]}"
        upstream="${branch_info[1]}"

        if [ ! -z "$upstream" ]; then
            if [ ${branches[$upstream]+nothing} ]; then
                branches[$upstream]+=" $branch"
            else
                branches[$upstream]="$branch"
            fi
        fi
    done <<< "$branches_and_upstreams"
}

# Determine where to start a rebase flowdown:given a function parameter.
#
# - "all" means find the main branch and start from there (main or master)
# - if no argument passed, uses the current branch
find_starting_branch() {
    starting_branch=$1
    if [ "$starting_branch" = "all" ]; then
        if git show-ref --verify --quiet refs/heads/master; then
            starting_branch="master"
        elif git show-ref --verify --quiet refs/heads/main; then
            starting_branch="main"
        elif git show-ref --verify --quiet refs/heads/develop; then
            starting_branch="develop"
        else
            echo "Unable to determine default base branch"
            exit 1
        fi
    elif [ -z "$starting_branch" ]; then
        starting_branch=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD)
    fi
}

find_current_branch() {
    current_branch=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD)
}

calculate_commits_ahead_of_upstream() {
    local branch=$1
    local upstream=$2
    commits_ahead_of_upstream=$(($(git rev-list --right-only --count $upstream...$branch)))
}
