#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(dirname "$0")"
source "$SCRIPT_DIRECTORY/util.sh"

find_starting_branch "all"

git fetch --no-tags origin "$starting_branch" && \
    "$SCRIPT_DIRECTORY/flow.sh" -b all && \
    git tidy && \
    git br
