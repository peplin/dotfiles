#!/usr/bin/env bash

# Squash all commits since the current HEAD forked from upstream. Optionally
# provide a custom message, otherwise uses the message from the first commit.

set -e

squash_all() {
    message=$1
    first_commit=$(git log @{upstream}..HEAD --pretty=format:"%h" | tail -1)
    git reset --soft $first_commit
    if [ ! -z $message ]; then
      git commit --amend -m $message
    else
      git commit --amend --no-edit
    fi
}

squash_all $1
