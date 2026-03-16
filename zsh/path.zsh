if [[ -d $HOME/bin ]]; then
    export PATH="$HOME/bin:$PATH"
    for DIR in ~/bin/*/; do
        [[ -d "$DIR" ]] && export PATH="$PATH:$DIR"
    done
fi

export PATH="$HOME/.local/bin:$ZSH/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"
