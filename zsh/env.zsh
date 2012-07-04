export EDITOR='vi'
export BROWSER=google-chrome
export PAGER="less"
export LESS="-R"

export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"

# add all first level subdirectories in ~/bin to PATH
for DIR in `find ~/bin/ -maxdepth 1 -type d`; do
    export PATH=$PATH:$DIR
done

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

#Disable "You have new mail" notifications
unset MAILCHECK

#GPG key
export DEBFULLNAME="Christopher Peplin"
export DEBEMAIL="chris.peplin@rhubarbtech.com"
export GPGKEY=D963BFAF

export HOSTNAME="`hostname`"

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi
