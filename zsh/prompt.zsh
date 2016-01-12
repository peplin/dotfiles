# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
autoload colors && colors

hg_prompt_info() {
    hg prompt --angle-brackets "\
<%{$fg[green]%}<branch>%{$reset_color%}>\
<@%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

git="/usr/bin/git"

git_branch() {
  echo $(timeout 1 $git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_prompt_info() {
  ref=$(timeout 1 $git symbolic-ref HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

git_dirty() {
    st=$(timeout 1 $git status 2>/dev/null | tail -n 1)
    if [[ $st == "" ]]
    then
        echo ""
    else
        if [[ "$st" =~ clean ]]
        then
            echo "%{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
        else
            echo "%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
        fi
    fi
}

unpushed () {
  timeout 1 $git cherry -v @{upstream} 2>/dev/null
}

project_name () {
  in_ford=$(pwd | grep 'ford')
  if [[ $in_ford == "" ]]
  then
    name=$(pwd | awk -F'dev/' '{print $2}' | awk -F/ '{print $1}')
  else
    name=$(pwd | awk -F'dev/ford/' '{print $2}' | awk -F/ '{print $1}')
  fi
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

export PROMPT=$'$(directory_name) $(project_name_color)$(git_dirty)$(need_push)\n> '

local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
export RPS1="${return_code}"

precmd() {
  title "zsh" "%55<...<%~"
}
