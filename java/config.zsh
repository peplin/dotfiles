fpath=($ZSH/java/functions $fpath)

if [ "$SHELL" = "/bin/zsh" ]; then
    autoload -U $ZSH/java/functions/*(:t)
fi
