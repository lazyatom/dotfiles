# OS X specific settings
export SVN_EDITOR='mate -w'
export GIT_EDITOR='mate -wl1'
export EDITOR='mate -w'
export GEM_OPEN_EDITOR='mate'
export LESSEDIT='mate -l %lm %f'

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
defaults write com.macromates.textmate OakDefaultLanguage E00B62AC-6B1C-11D9-9B1F-000D93589AF6

case $OSTYPE in
  darwin10*)
		export ARCHFLAGS="-arch x86_64"
  ;;;
esac

ulimit -n 4096