if command -v nvim >/dev/null 2>&1; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

if command -v google-chrome-stable >/dev/null 2>&1; then
    export BROWSER=google-chrome-stable
fi
export PAGER="less -FXR"
export LESS="-R"

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

#Disable "You have new mail" notifications
unset MAILCHECK

#GPG key
export DEBFULLNAME="Christopher Peplin"
export DEBEMAIL="chris.peplin@rhubarbtech.com"
export GPGKEY=D963BFAF

export HOSTNAME="`hostname`"
