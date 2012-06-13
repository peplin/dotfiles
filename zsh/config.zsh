fpath=($ZSH/zsh/functions $fpath)

if [ "$SHELL" = "/bin/zsh" ]; then
    autoload -U $ZSH/zsh/functions/*(:t)

    # Autoload zsh modules when they are referenced
    zmodload -a zsh/stat stat
    zmodload -a zsh/zpty zpty
    zmodload -a zsh/zprof zprof
    zmodload -ap zsh/mapfile mapfile
    zmodload zsh/complist

    autoload colors
    autoload zsh/terminfo
    autoload -U url-quote-magic
    zle -N self-insert url-quote-magic
fi

DIRSTACKSIZE=15
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

if [ "$SHELL" = "/bin/zsh" ]; then
    # Set/unset shell options (case and underscore insensitive)
    setopt append_history
    setopt hist_ignore_dups
    setopt hist_no_store # don't save 'history' cmd in history
    setopt extended_history # add timestamps to history
    setopt hist_ignore_all_dups  # don't record dupes in history
    setopt hist_reduce_blanks

    setopt extended_glob
    setopt notify
    setopt pushd_to_home
    setopt cdable_vars
    setopt auto_list
    setopt rec_exact
    setopt long_list_jobs
    setopt auto_resume
    setopt pushd_silent
    setopt auto_pushd
    setopt pushd_minus
    setopt rcquotes
    setopt mail_warning
    setopt auto_param_slash # adds slash at end of tabbed dirs
    setopt glob_dots # find dotfiles easier
    setopt hash_cmds # save cmd location to skip PATH lookup
    setopt list_rows_first # completion options left-to-right, top-to-bottom
    setopt list_types # show file types in list
    setopt mark_dirs # adds slash to end of completed dirs

    setopt no_hup
    setopt local_options # allow functions to have local options
    setopt local_traps # allow functions to have local traps
    setopt prompt_subst
    setopt complete_in_word

    unsetopt bgnice
    unsetopt beep
    unsetopt list_beep

    bindkey -e
    bindkey ';5A' vi-beginning-of-line
    bindkey ';5B' vi-end-of-line
    bindkey ';5C' forward-word
    bindkey ';5D' backward-word
    bindkey '^N' forward-word
    bindkey '^B' backward-word

    if [ -e /etc/zsh_command_not_found ]; then
        source /etc/zsh_command_not_found
    fi
fi
