if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

export EDITOR='vi'
export PAGER="less"
export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

#Disable "You have new mail" notifications
unset MAILCHECK

#GPG key
export DEBFULLNAME="Christopher Peplin"
export DEBEMAIL="chris.peplin@rhubarbtech.com"
export GPGKEY=D963BFAF

export HOSTNAME="`hostname`"

# workaround for Karmic - http://bit.ly/T8MIc
export GDK_NATIVE_WINDOWS=true

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
