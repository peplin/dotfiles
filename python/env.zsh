export PYTHONSTARTUP=$HOME/.dotfiles/python/startup/startup.py
export PYTHONPATH=$PYTHONPATH
export PYTHONUSERDIR=$HOME/.dotfiles/python/startup

export PROJECT_HOME=$PROJECTS
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

source `which virtualenvwrapper_lazy.sh`

export NOSE_PROGRESSIVE_FUNCTION_COLOR=0
export NOSE_PROGRESSIVE_DIM_COLOR=11
export NOSE_PROGRESSIVE_BAR_FILLED_COLOR=2
export NOSE_PROGRESSIVE_BAR_EMPTY_COLOR=7
