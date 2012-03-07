fpath=($ZSH/git/functions $fpath)

if [ "$SHELL" = "/bin/zsh" ]; then
    autoload -U $ZSH/git/functions/*(:t)
fi
