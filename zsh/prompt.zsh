# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
autoload colors && colors

git="/usr/bin/git"

git_branch() {
  echo $(timeout 0.1 $git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_prompt_info() {
  ref=$(timeout 0.1 $git symbolic-ref HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

git_dirty() {
    st=$(timeout 0.2 $git --no-optional-locks status 2>/dev/null | tail -n 1)
    if [[ $st == "" ]]
    then
        echo ""
    else
        if [[ "$st" =~ clean ]]
        then
            echo "%{$fg[green]%}$(git_branch)%{$reset_color%}"
        else
            echo "%{$fg_bold[red]%}$(git_branch)%{$reset_color%}"
        fi
    fi
}

unpushed () {
  timeout 0.1 $git cherry -v @{upstream} 2>/dev/null
}

project_name () {
  name=$(pwd | awk -F'dev/' '{print $2}' | awk -F/ '{print $1}')
  echo $name
}

project_name_color () {
  name=$(project_name)
  echo "%{\e[0;35m%}${name}%{\e[0m%}"
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo "%{$fg_bold[red]%}+%{$reset_color%}"
  fi
}

directory_name(){
  echo "%{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}"
}

aws_vault_profile () {
  if [[ -n ${AWS_VAULT} ]]; then
    echo "[AWS: ${AWS_VAULT}] "
  fi
}

setopt PROMPT_SUBST
export PROMPT=$'$(aws_vault_profile)$(directory_name) $(project_name_color)$(git_dirty)$(need_push)\n$ '

local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
export RPS1="${return_code}"

precmd() {
  title "zsh" "%55<...<%~"
}
