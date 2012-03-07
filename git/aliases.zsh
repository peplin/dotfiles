function git(){hub "$@"}
alias gl='git pull'
alias glr='git pull --rebase'
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gitcheck="find . -maxdepth 1 -type d -exec sh -c 'echo {}; cd {} && git wtf; echo' \;"
