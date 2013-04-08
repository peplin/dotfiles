fpath=($ZSH/functions $fpath)

if [ "$SHELL" = "/bin/zsh" ]; then
    autoload -U $ZSH/functions/*(:t)

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
    setopt inc_append_history share_history  # adds history incrementally and share it across sessions
    setopt hist_verify # allow confirmation before running with history subst.

    setopt extended_glob
    setopt notify
    setopt pushd_to_home
    setopt pushd_silent
    setopt auto_list
    setopt rec_exact
    setopt long_list_jobs
    setopt auto_resume
    setopt auto_pushd
    setopt pushd_minus
    setopt rcquotes
    setopt auto_param_slash # adds slash at end of tabbed dirs
    setopt mark_dirs # adds slash to end of completed dirs
    setopt glob_dots # find dotfiles easier
    setopt hash_cmds # save cmd location to skip PATH lookup
    setopt list_rows_first # completion options left-to-right, top-to-bottom
    setopt list_types # show file types in list

    setopt no_hup
    setopt local_options # allow functions to have local options
    setopt local_traps # allow functions to have local traps
    setopt prompt_subst
    setopt complete_in_word
    setopt correct
    setopt ignore_eof

    # don't expand aliases _before_ completion has finished
    #   like: git comm-[tab]
    setopt complete_aliases

    unsetopt bgnice
    unsetopt beep
    unsetopt list_beep

    bindkey -e
    bindkey ';5A' vi-beginning-of-line
    bindkey ';5B' vi-end-of-line
    bindkey ';5C' emacs-forward-word
    bindkey ';5D' emacs-backward-word
    bindkey '^[Od' backward-word
    bindkey '^[Oc' forward-word
    bindkey '^[[7~' beginning-of-line
    bindkey '^[[3~' delete-char
    bindkey '^[[8~' end-of-line

    bindkey '^N' forward-word
    bindkey '^B' backward-word

    if [ -e /etc/zsh_command_not_found ]; then
        source /etc/zsh_command_not_found
    fi
fi
