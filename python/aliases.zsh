alias pyweb='python -m SimpleHTTPServer'
alias mrs='./manage.py runserver'
alias ms='./manage.py shell'
alias fab='nocorrect python /usr/local/bin/fab'
alias pylint='python /usr/local/bin/pylint'

validatejson() {
    cat $1 | python -m json.tool
}

function remote_shell() {
    environment=$3 || "PRODUCTION"
    /usr/bin/env ssh $1 "( DEPLOYMENT_TYPE=$environment cd $2 && env/bin/python ./manage.py shell )"
}
