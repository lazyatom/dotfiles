# OS X specific settings
export SVN_EDITOR='subl -w'
export GIT_EDITOR='subl -wl1'
export EDITOR='subl'
export GEM_OPEN_EDITOR='subl'
export BUNDLER_EDITOR='subl'
export LESSEDIT='subl -l %lm %f'

# Use OS X version of SSH with agent forwarding
alias ssh='/usr/bin/ssh -A'
alias scp='/usr/bin/scp'
alias sftp='/usr/bin/sftp'

alias ls='ls -ahGl'

fpath=(~/.dotfiles/zsh/osx/functions $fpath)
autoload -U ~/.dotfiles/zsh/osx/functions/*(:t)

# Mac defaults for apps
defaults write com.apple.RemoteDesktop DoNotSendSystemKeys -bool YES
case $OSTYPE in
  darwin10*)
		export ARCHFLAGS="-arch x86_64"
  ;;;
esac

ulimit -n 4096
