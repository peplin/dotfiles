
if command -v nvim >/dev/null 2>&1; then
    alias vim='nvim -O'
else
    alias vim='vim -O'
fi

export PATH="$PATH:$HOME/.vim/bundle/fzf/bin"
