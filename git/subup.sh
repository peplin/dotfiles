#!/usr/bin/env bash

# Update all currently initialized submodules to the latest commit on their
# tracking branch, then stage the result.

set -euo pipefail

initialized=$(git submodule foreach --quiet 'echo $sm_path')

if [ -z "$initialized" ]; then
    echo "No initialized submodules found."
    exit 0
fi

echo "$initialized" | while read -r sm_path; do
    echo "Updating $sm_path..."
    git submodule update --init "$sm_path"
done
