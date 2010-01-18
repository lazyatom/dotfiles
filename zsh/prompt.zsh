# git_diff_color() {
#   changes=$(git status)
#   case $changes in
#     *Untracked*)
#       echo "%{$fg[red]%}"
#       return
#     ;;;
#     
#     *updated*)
#       echo "%{$fg[red]%}"
#       return
#     ;;;
#     
#     *committed*)
#       echo "%{$fg[green]%}"
#       return
#     ;;;
#   esac
# }
# 
# git_prompt_info() {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "($(git_diff_color)${ref#refs/heads/}$(host_prompt_color))"
# }
# 
# autoload -U colors
# colors
# 
# setopt prompt_subst
# 
# # If we're running in an ssh session, use a different colour 
# # than if we're on a local machine
# 
# host_prompt_color() {
#   case ${SSH_CLIENT} in 
#     [0-9]*)
#       echo "%{$fg[yellow]%}"
#     ;;;
#     
#     *)
#       echo "%{$fg[blue]%}"
#     ;;;
#   esac
# }
# 
# export PROMPT=$'$(host_prompt_color)%n@%m:%~$(git_prompt_info)$ %{$fg[white]%}'

autoload colors; colors
autoload -U add-zsh-hook
add-zsh-hook precmd prompt_lazyatom_precmd

function prompt_lazyatom_precmd() {
  local previous_return_value=$?;
  prompt="%{$fg[light_gray]%}%c%{$fg[yellow]%}$(lazyatom_git_prompt_info)%{$fg[white]%}"
  if test $previous_return_value -eq 0
  then
    export PROMPT="%{$fg[green]%}➜  %{$fg[white]%}${prompt}%{$fg[green]%} $%{$fg[white]%} "
  else
    export PROMPT="%{$fg[red]%}➜  %{$fg[white]%}${prompt}%{$fg[red]%} $%{$fg[white]%} "
  fi
}

function lazyatom_git_prompt_info() {
  branch=$(git symbolic-ref HEAD 2> /dev/null) || return
  git_status="$(git status 2> /dev/null)"
  state=""
  case $git_status in
    *Changed\ but\ not\ updated*)
      state="%{$fg[red]%}⚡"
    ;;;
    *Untracked\ files*)
      state="%{$fg[red]%}⚡"
    ;;;
  esac
  
  remote=""
  case $git_status in
    *Your\ branch\ is\ ahead*)
      remote="%{$fg[yellow]%}↑"
    ;;;
    
    *Your\ branch\ is\ behind*)
      remote="%{$fg[yellow]%}↓"
    ;;;
    
    "Your branch and")
      remote="%{$fg[yellow]%}"
    ;;;
  esac
  echo " %{$fg[yellow]%}(${branch#refs/heads/})${remote}${state}"
}