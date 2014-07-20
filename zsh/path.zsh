export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"
export PATH="$PATH:$HOME/.dynamic-colors/bin"
source $HOME/.dynamic-colors/completions/dynamic-colors.zsh

# add all first level subdirectories in ~/bin to PATH
for DIR in `find ~/bin/ -maxdepth 1 -type d`; do
    export PATH=$PATH:$DIR
done
