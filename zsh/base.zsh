system_name=`uname -a`

fpath=(~/.dotfiles/zsh/functions $fpath)

source ~/.dotfiles/zsh/completion.zsh
source ~/.dotfiles/zsh/prompt.zsh
source ~/.dotfiles/zsh/title.zsh
source ~/.dotfiles/zsh/misc.zsh
source ~/.dotfiles/zsh/history.zsh

autoload -U ~/.dotfiles/zsh/functions/*(:t)

alias ruby="ruby_or_irb"

setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps

# Load vendor specific scripts

case $system_name in
  Darwin*)
    source ~/.dotfiles/zsh/osx/osx.zsh
    ;;
  *)
    source ~/.dotfiles/zsh/linux/linux.zsh
    ;;;
esac
