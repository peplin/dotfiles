export PYTHONSTARTUP=$HOME/.dotfiles/python/startup/startup.py
export PYTHONPATH=$PYTHONPATH:$PROJECTS/bueda/ops
export PYTHONUSERDIR=$HOME/.dotfiles/python/startup

export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

if [ -x /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
