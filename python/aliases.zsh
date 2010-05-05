alias pyweb='python -m SimpleHTTPServer'
alias rs='./manage.py runserver'
alias rc='./manage.py shell'

validatejson() {
    cat $1 | python -m simplejson.tool
}
