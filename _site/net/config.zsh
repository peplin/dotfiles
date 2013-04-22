fpath=($ZSH/net/functions $fpath)

if [ "$SHELL" = "/bin/zsh" ]; then
    autoload -U $ZSH/net/functions/*(:t)
fi
