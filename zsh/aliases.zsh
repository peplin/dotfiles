alias dotvim='vim $ZSH'
alias dotcd='cd $ZSH'
alias reload='. ~/.zshrc'

alias markdown2pdf='/usr/bin/markdown2pdf --template ~/Dropbox/reference/markdown.tex'

alias alert='notify-send -i gnome-terminal \
    "[$?] $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/;\s*alert$//'\'')"'

calc() { awk "BEGIN{ print $* }" ;}

urlencode() { echo `perl -MURI::Escape -e "print uri_escape('$1');"` ;}
