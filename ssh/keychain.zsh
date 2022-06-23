if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    ln -sf ~/.1password/agent.sock /tmp/$USER-ssh_auth_sock;
fi
