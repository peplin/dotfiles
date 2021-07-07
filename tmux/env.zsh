if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" /tmp/$USER-ssh_auth_sock;
fi
export SSH_AUTH_SOCK=/tmp/$USER-ssh_auth_sock;

if [ $SSH_TTY ] && [ ! $WINDOW ] && [ ! $DISPLAY ]; then
    if [[ -z "$TMUX" ]] ;then
        if which tmux >/dev/null 2>&1; then
            ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
            if [[ -z "$ID" ]] ;then # if not available create a new one
                tmux new-session
            else
                tmux attach-session -t "$ID" # if available attach to it
            fi
        fi
    fi
fi
