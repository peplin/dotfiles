alias dotvim='vim $ZSH'
alias dotcd='cd $ZSH'

alias reload='. ~/.zshrc'

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

alias fab='nocorrect fab'

calc() { awk "BEGIN{ print $* }" ;}

urlencode() { echo `perl -MURI::Escape -e "print uri_escape('$1');"` ;}
