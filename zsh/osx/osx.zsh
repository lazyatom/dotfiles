# OS X specific settings
export EDITOR='emacsclient'
export VISUAL="$EDITOR -n"
export GUI_EDITOR=$VISUAL
export GEM_OPEN_EDITOR=$GUI_EDITOR
export BUNDLER_EDITOR=$GUI_EDITOR
export VIM_EDITOR="nvim +star -c ':0'"
export SVN_EDITOR=$VIM_EDITOR
export GIT_EDITOR=$VIM_EDITOR
export LESSEDIT='vim -l %lm %f'

# Use OS X version of SSH with agent forwarding
alias ssh='/usr/bin/ssh -A'
alias scp='/usr/bin/scp'
alias sftp='/usr/bin/sftp'

alias ls='ls -ahGl'

fpath=(~/.dotfiles/zsh/osx/functions $fpath)
autoload -U ~/.dotfiles/zsh/osx/functions/*(:t)

case $OSTYPE in
  darwin10*)
		export ARCHFLAGS="-arch x86_64"
  ;;;
esac

ulimit -n 4096
