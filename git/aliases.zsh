alias gitcheck="find . -maxdepth 1 -type d -exec sh -c 'echo {}; cd {} && git wtf; echo' \;"
alias gitpurgelocal="git checkout master && git branch --merged | grep -v master | xargs git branch -d"
alias gitpurgeremote="git checkout master && git remote prune origin && git branch -r --merged | grep -v master | sed -e 's/origin\\//:/' | xargs git push origin"
