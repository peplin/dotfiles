export PYTHONSTARTUP=$HOME/.dotfiles/python/startup/startup.py
export PYTHONPATH=$PYTHONPATH:$PROJECTS/bueda/ops
export PYTHONUSERDIR=$HOME/.dotfiles/python/startup

export PROJECT_HOME=$PROJECTS
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

export PYTHONDONTWRITEBYTECODE=1

if [ -x /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [ -x /usr/bin/virtualenvwrapper.sh ]; then
    source /usr/bin/virtualenvwrapper.sh
fi
