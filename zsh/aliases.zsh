alias dotcd='cd $ZSH'
alias reload='. ~/.zshrc'
alias xclip='xclip -sel clip'

alias markdown2pdf='/usr/bin/markdown2pdf --template ~/Dropbox/reference/markdown.tex'

calc() { awk "BEGIN{ print $* }" ;}

urlencode() { echo `perl -MURI::Escape -e "print uri_escape('$1');"` ;}
