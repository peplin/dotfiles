if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    ln -sf $SSH_AUTH_SOCK /tmp/$USER-ssh_auth_sock;
fi
