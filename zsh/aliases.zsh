alias dotvim='vim $ZSH'
alias dotcd='cd $ZSH'

alias reload='. ~/.zshrc'

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias find='noglob find'
alias knife='noglob knife'
alias rake='noglob rake'
alias curl='noglob curl'
alias httparty='noglob httparty'
alias wget='noglob wget'

alias markdown2pdf='/usr/bin/markdown2pdf --template ~/Dropbox/reference/markdown.tex'

alias alert='notify-send -i gnome-terminal \
    "[$?] $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/;\s*alert$//'\'')"'

calc() { awk "BEGIN{ print $* }" ;}

urlencode() { echo `perl -MURI::Escape -e "print uri_escape('$1');"` ;}
