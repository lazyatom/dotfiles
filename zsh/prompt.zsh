autoload colors; colors
autoload -U add-zsh-hook
add-zsh-hook precmd prompt_lazyatom_precmd

function prompt_lazyatom_precmd() {
  local previous_return_value=$?;
  prompt="%{$fg[light_gray]%}%c%{$fg[yellow]%}$(lazyatom_git_prompt_info)%{$fg[white]%}"
  if test $previous_return_value -eq 0
  then
    export PROMPT="$(host_prompt_color)$(host_prompt_start) %{$fg[white]%}${prompt}%{$fg[green]%} $%{$fg[white]%} "
  else
    export PROMPT="%{$fg[red]%}$(host_prompt_start) %{$fg[white]%}${prompt}%{$fg[red]%} $%{$fg[white]%} "
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
      remote="%{$fg[yellow]%}⇡"
    ;;;

    *Your\ branch\ is\ behind*)
      remote="%{$fg[yellow]%}⇣"
    ;;;

    "Your branch and")
      remote="%{$fg[yellow]%}"
    ;;;
  esac
  echo " %{$fg[yellow]%}${branch#refs/heads/}${state}${remote}$(git_pair_info)"
}

git_pair_info() {
  pair=$(git config pair.initials) || return
  case ${pair} in
    [a-z]*)
      echo "%{$fg[blue]%}‣${pair}"
    ;;;
  esac
}

host_prompt_start() {
  case ${SSH_CLIENT} in
    [0-9]*)
      echo "❯➜"
    ;;;
    *)
      echo "➜"
    ;;;
  esac
}

host_prompt_color() {
  case ${SSH_CLIENT} in
    [0-9]*)
      echo "%{$fg[blue]%}"
    ;;;
    *)
      echo "%{$fg[green]%}"
    ;;;
  esac
}