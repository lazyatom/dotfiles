# OS X specific settings
export PATH=/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$PATH
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

localhost() {
  sudo dscl localhost -create /Local/Default/Hosts/$1 IPAddress 127.0.0.1
  echo "Added $1 at address 127.0.0.1"
}

# Mac defaults for apps
defaults write com.apple.RemoteDesktop DoNotSendSystemKeys -bool YES
case $OSTYPE in
  darwin10*)
		export ARCHFLAGS="-arch x86_64"
  ;;;
esac

ulimit -n 4096
