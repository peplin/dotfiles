function git(){hub "$@"}
alias gl='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glr='git pull --rebase'
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gitcheck="find . -maxdepth 1 -type d -exec sh -c 'echo {}; cd {} && git wtf; echo' \;"
