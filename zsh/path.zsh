if [[ -d $HOME/bin ]]; then
    export PATH="$HOME/bin:$PATH"
    # add all first level subdirectories in ~/bin to PATH
    for DIR in `find ~/bin/ -maxdepth 1 -type d`; do
        export PATH=$PATH:$DIR
    done
fi

export PATH="$HOME/.local/bin:$ZSH/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"
