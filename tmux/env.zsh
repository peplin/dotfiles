if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    mkdir -p $HOME/.ssh
    ln -sf "$SSH_AUTH_SOCK" $HOME/.ssh/ssh_auth_sock.$HOSTNAME
fi
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock.$HOSTNAME

# Configure iTerm's ENQ answer back to be "iterm2" so we can identify what
# when the client is using that terminal. Use that to determine if we should
# enable tmux control mode.
if [[ -t 1 ]]; then
    sleep 0.2
    SHELL_ID=$(stty raw min 0 time 1 < /dev/tty; echo -ne '\005' > /dev/tty; read -s REPLY < /dev/tty; stty cooked < /dev/tty; echo -n "$REPLY" | tr -d '[:cntrl:]')
fi
export SHELL_ID

if [[ "$SHELL_ID" =~ iterm2  ]]; then
    CONTROL_MODE_OPTIONS="-CC"
else
    CONTROL_MODE_OPTIONS=""
fi

if [ $SSH_TTY ] && [ ! $WINDOW ] && [ ! $DISPLAY ]; then
    if [[ -z "$TMUX" ]] ;then
        if which tmux >/dev/null 2>&1; then
            session=mysession$SHELL_ID
            if tmux has-session -t "$session" 2>/dev/null; then
                tmux $CONTROL_MODE_OPTIONS attach-session -t "$session"_
            else
                tmux $CONTROL_MODE_OPTIONS new-session -s "$session"
            fi
        fi
    fi
fi
