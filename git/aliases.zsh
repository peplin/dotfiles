alias git='hub'
alias gca='git commit -a'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gitcheck="find . -maxdepth 1 -type d -exec sh -c 'echo {}; cd {} && git wtf; echo' \;"
