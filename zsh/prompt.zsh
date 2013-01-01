# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
autoload colors && colors

function hg_prompt_info {
    hg prompt --angle-brackets "\
<%{$fg[green]%}<branch>%{$reset_color%}>\
<@%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_prompt_info () {
    ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
    if [[ -n $(/usr/bin/git status -s 2> /dev/null) ]]; then
        echo -n "%{$fg_no_bold[red]%}"
    else
        echo -n "%{$fg[green]%}"
    fi
    echo "${ref#refs/heads/}%{$reset_color%}$(need_push)"
}

unpushed () {
  /usr/bin/git cherry -v `/usr/bin/git config --get branch.master.remote`/$(git_branch) 2>/dev/null
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
    echo "%{\e[0;32m%}+%{\e[0m%}"
  fi
}

directory_name(){
  title "zsh" "%55<...<%~"
  echo "%{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}"
}

PROMPT=$'$(directory_name) $(project_name_color)$(git_prompt_info)$(hg_prompt_info)\n> '

local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
RPS1="${return_code}"
