autoload colors && colors

typeset -g _git_info=""
typeset -g _project_name=""
typeset -g _git_info_pwd=""
typeset -g _async_git_pid=0

_async_git_info() {
    local dir="$1"
    cd "$dir" 2>/dev/null || return

    local git_dir
    git_dir=$(git rev-parse --git-dir 2>/dev/null) || return

    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || branch=$(git rev-parse --short HEAD 2>/dev/null) || return

    local dirty=""
    if ! git --no-optional-locks diff --quiet --ignore-submodules HEAD 2>/dev/null || \
       [[ -n $(git --no-optional-locks status --porcelain 2>/dev/null | head -1) ]]; then
        dirty="1"
    fi

    local toplevel project=""
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n "$toplevel" ]]; then
        local real_dev="${HOME:A}/dev/"
        local rel="${toplevel#$real_dev}"
        [[ "$rel" != "$toplevel" ]] && project="${rel##*/}"
    fi

    local color="green"
    [[ -n "$dirty" ]] && color="red"
    printf '\x1f%s\x1f%s\x1f%s\x1f%s' "$branch" "$color" "$project" "$dir"
}

_handle_async_git() {
    local output
    read -r -u $1 output
    zle -F $1
    exec {1}<&-

    if [[ $_async_git_pid -ne 0 ]]; then
        _async_git_pid=0
    fi

    [[ -z "$output" ]] && return

    local branch color project dir
    IFS=$'\x1f' read -r _ branch color project dir <<< "$output"

    [[ "$dir" != "$PWD" ]] && return

    local sep="%{$fg[yellow]%} %{$reset_color%}"
    if [[ "$color" == "red" ]]; then
        _git_info="${sep}%{$fg_bold[red]%}${branch}%{$reset_color%}"
    else
        _git_info="${sep}%{$fg[green]%}${branch}%{$reset_color%}"
    fi
    if [[ -n "$project" ]]; then
        _project_name="%{\e[0;35m%}${project}%{\e[0m%}"
    else
        _project_name=""
    fi
    _git_info_pwd="$PWD"

    zle && zle reset-prompt
}

_start_async_git() {
    if [[ $_async_git_pid -ne 0 ]]; then
        kill $_async_git_pid 2>/dev/null
        _async_git_pid=0
    fi

    local fd
    exec {fd}< <(_async_git_info "$PWD")
    _async_git_pid=$!
    zle -F $fd _handle_async_git
}

_get_git_info() {
    if [[ "$_git_info_pwd" == "$PWD" ]]; then
        echo "$_git_info"
    fi
}

_get_project_name() {
    if [[ "$_git_info_pwd" == "$PWD" ]]; then
        echo "$_project_name"
    fi
}

directory_name() {
    echo "%{$fg[yellow]%}${HOST%%.*}%{$reset_color%}%{$fg[green]%}:${PWD/#$HOME/~}%{$reset_color%}"
}

aws_vault_profile() {
    if [[ -n ${AWS_VAULT} ]]; then
        echo "[AWS: ${AWS_VAULT}] "
    fi
}

setopt PROMPT_SUBST
export PROMPT=$'$(aws_vault_profile)$(directory_name) $(_get_project_name)$(_get_git_info)\n$ '

local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
export RPS1="${return_code}"

precmd() {
    title "zsh" "%55<...<%~"

    if [[ "$_git_info_pwd" != "$PWD" ]]; then
        _git_info=""
        _project_name=""
    fi

    _start_async_git
}
