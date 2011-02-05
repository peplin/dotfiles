test $SSH_AUTH_SOCK && [[ $SSH_AUTH_SOCK != "/tmp/ssh-agent-$USER-screen" ]] && \
    ln -sf "$SSH_AUTH_SOCK" "/tmp/ssh-agent-$USER-screen"

if [ $SSH_TTY ] && [ ! $WINDOW ]; then
  SCREENLIST=`screen -ls | grep 'Attached'`
  if [ $? -eq "0" ]; then
    echo -e "Screen is already running and attached:\n ${SCREENLIST}"
  else
    screen -U -R
  fi
fi
