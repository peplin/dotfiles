
if command -v brew >/dev/null 2>&1; then
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

LS_SUFFIX=""
if ls --version >/dev/null 2>&1; then
    # GNU ls
    LS_SUFFIX=" -N --group-directories-first --color=auto"
elif ls -G >/dev/null 2>&1; then
    # BSD ls
fi

if [ "$TERM" != "dumb" ]; then
    if command -v dircolors >/dev/null 2>&1; then
        eval $(dircolors -b ~/.dircolors)
    fi
fi

alias ls="ls -N$LS_SUFFIX"
alias ll="ls -lh$LS_SUFFIX"
alias la="ls -lha$LS_SUFFIX"

alias grep='grep --color=auto'

alias combinepdf='gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=output.pdf -dBATCH'
