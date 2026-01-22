autoload colors && colors

typeset -g _git_info=""
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
    if ! git diff --quiet --ignore-submodules HEAD 2>/dev/null || \
       [[ -n $(git status --porcelain 2>/dev/null | head -1) ]]; then
        dirty="1"
    fi

    if [[ -n "$dirty" ]]; then
        printf '\x1f%s\x1fred\x1f%s' "$branch" "$dir"
    else
        printf '\x1f%s\x1fgreen\x1f%s' "$branch" "$dir"
    fi
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

    local branch color dir
    IFS=$'\x1f' read -r _ branch color dir <<< "$output"

    [[ "$dir" != "$PWD" ]] && return

    if [[ "$color" == "red" ]]; then
        _git_info="%{$fg_bold[red]%}${branch}%{$reset_color%}"
    else
        _git_info="%{$fg[green]%}${branch}%{$reset_color%}"
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

project_name() {
    local name
    name=$(pwd | awk -F'dev/' '{print $2}' | awk -F/ '{print $1}')
    echo $name
}

project_name_color() {
    local name
    name=$(project_name)
    echo "%{\e[0;35m%}${name}%{\e[0m%}"
}

directory_name() {
    echo "%{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}"
}

aws_vault_profile() {
    if [[ -n ${AWS_VAULT} ]]; then
        echo "[AWS: ${AWS_VAULT}] "
    fi
}

setopt PROMPT_SUBST
export PROMPT=$'$(aws_vault_profile)$(directory_name) $(project_name_color)$(_get_git_info)\n$ '

local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
export RPS1="${return_code}"

precmd() {
    title "zsh" "%55<...<%~"

    if [[ "$_git_info_pwd" != "$PWD" ]]; then
        _git_info=""
    fi

    _start_async_git
}
