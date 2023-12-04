if [[ -d $HOME/bin ]]; then
    export PATH="$HOME/bin:$PATH"
    # add all first level subdirectories in ~/bin to PATH
    for DIR in `find ~/bin/ -maxdepth 1 -type d`; do
        export PATH=$PATH:$DIR
    done
fi

export PATH="/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.npm/bin"
