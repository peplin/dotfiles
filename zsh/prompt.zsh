# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
autoload colors && colors

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}
 
git_dirty() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo "%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}
 
git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}
 
project_name () {
  in_bueda=$(pwd | grep 'bueda') 
  if [[ $in_bueda == "" ]]
  then
    name=$(pwd | awk -F'dev/' '{print $2}' | awk -F/ '{print $1}')
  else
    name=$(pwd | awk -F'dev/bueda/' '{print $2}' | awk -F/ '{print $1}')
  fi
  echo $name
}
 
project_name_color () {
  name=$(project_name)
  echo "%{\e[0;35m%}${name}%{\e[0m%}"
}
 
unpushed () {
  /usr/bin/git cherry -v origin/$(git_branch) 2>/dev/null
}
 
need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo "%{\e[0;32m%}+%{\e[0m%}"
  fi
}

directory_name(){
  echo "%{$fg_bold[green]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'$(directory_name) $(project_name_color)$(git_dirty)$(need_push)\n› '
set_prompt () {
    export RPROMPT=""
}
 
precmd() {
  set_prompt
}
