# Uses git's autocompletion for inner commands. Assumes an install of git's
# zsh `git-completion` script at $completion belowi.
completion='/usr/share/git/completion/git-completion.zsh'

if test -f $completion
then
  fpath=($completion $fpath)
fi
