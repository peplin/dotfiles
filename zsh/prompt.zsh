# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
autoload colors && colors

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if [[ -n $(/usr/bin/git status -s 2> /dev/null) ]]; then
      echo "%{$fg_no_bold[red]%}$(git_prompt_info)%{$reset_color%}"
  else
      echo "%{$fg_no_bold[green]%}$(git_prompt_info)%{$reset_color%}"
  fi
}

git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
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
  echo "%{$fg_no_bold[green]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'$(directory_name) $(project_name_color)$(git_dirty)$(need_push)\n› '
set_prompt () {
    export RPROMPT=""
}

precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
  set_prompt
}
