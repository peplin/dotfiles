# ripgreprc doesn't support expanding variables like $HOME or ~
alias ack='noglob rg --ignore-file=$HOME/.ignore'
