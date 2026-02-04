autoload -U compinit
compinit

if command -v jj >/dev/null 2>&1; then
    source <(jj util completion zsh)
fi
