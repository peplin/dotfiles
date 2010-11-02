alias rc='rails console'
alias rs='rails server'
alias tlog='tail -f log/development.log'
alias s="ps aux | grep \"[r]uby\" | grep \"rails server\" || echo \"You're not running any, dawg.\""

function remote_console() {
  /usr/bin/env ssh $1 "( cd $2 && ruby script/console production )"
}
