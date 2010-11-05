alias pyweb='python -m SimpleHTTPServer'
alias mrs='./manage.py runserver'
alias ms='./manage.py shell'

validatejson() {
    cat $1 | python -m simplejson.tool
}

function remote_shell() {
    environment=$3 || "PRODUCTION" 
    /usr/bin/env ssh $1 "( DEPLOYMENT_TYPE=$environment cd $2 && env/bin/python ./manage.py shell )"
}
