
if command -v brew >/dev/null 2>&1; then
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

if [ "$TERM" != "dumb" ]; then
    if command -v dircolors >/dev/null 2>&1; then
        eval "`dircolors -b`"
    fi
    alias ls='ls --group-directories-first --color=auto'
fi

alias ll='ls -lh'
alias la='ls -lha'

alias ..='cd ..'
function cdls() {
    cd $1 && ls
}

alias grep='grep --color=auto'
alias ack='ag'

# grep history
alias gh='fc -l 0 | grep'

alias dh='dirs -v'  # directory history

# Find a file with a pattern in name:
# Find a file with pattern $1 in name and Execute $2 on it:
function findExec() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

alias fe=findExec

alias spwd='pwd | pbcopy'  # copy the current working directory to the clipboard

alias diffcol="diff -y -W 160" # side by side diff 160 columns wide

alias combinepdf='gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=output.pdf -dBATCH'
