#!/usr/bin/env bash
# Count lines of code in a folder in git, per day, over the last 3 months.
# Uses pygount (install: uv tool install pygount) for accurate source counting.
# Usage: ./loc_over_time.sh <folder>
# Output: CSV to stdout

set -euo pipefail

folder="${1:?Usage: $0 <folder>}"
days=10
tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

echo "date,code,documentation,empty"

for i in $(seq "$days" -1 0); do
    date=$(date -d "today - ${i} days" +%Y-%m-%d)
    commit=$(git log -1 --format=%H --before="${date}T23:59:59" -- 2>/dev/null || true)
    if [[ -z "$commit" ]]; then
        continue
    fi

    # Extract the folder at that commit into a temp directory
    checkout="$tmpdir/$date"
    mkdir -p "$checkout"
    git archive "$commit" -- "$folder" 2>/dev/null | tar -x -C "$checkout" 2>/dev/null || continue

    # Run pygount and extract totals from JSON
    counts=$(pygount --format json "$checkout/$folder" 2>/dev/null \
        | python3 -c "import sys,json; s=json.load(sys.stdin)['summary']; print(s['totalCodeCount'], s['totalDocumentationCount'], s['totalEmptyCount'])")

    read -r code doc empty <<< "$counts"
    echo "${date},${code},${doc},${empty}"

    rm -rf "$checkout"
done
