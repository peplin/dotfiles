if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" $HOME/.ssh/ssh_auth_sock.$HOSTNAME
fi
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock.$HOSTNAME


if [ $SSH_TTY ] && [ ! $WINDOW ] && [ ! $DISPLAY ]; then
    if [[ -z "$TMUX" ]] ;then
        if which tmux >/dev/null 2>&1; then
            session=mysession
            if tmux has-session -t "$session" 2>/dev/null; then
                tmux -CC attach-session -t "$session"
            else
                tmux -CC new-session -s "$session"
            fi
        fi
    fi
fi
