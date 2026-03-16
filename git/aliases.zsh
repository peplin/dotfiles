alias gpr='git push origin --force-with-lease && gh pr create --draft --base $(git rev-parse --abbrev-ref HEAD@{upstream})'
