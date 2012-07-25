alias rc='rails console'
alias rs='rails server'

function remote_console() {
  /usr/bin/env ssh $1 "( cd $2 && ruby script/console production )"
}
