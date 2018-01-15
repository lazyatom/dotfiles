export RBENVDIR="$HOME/.rbenv"
export PATH=".bundle/bin:$RBENVDIR/bin:$HOME/.homebrew/share/npm/bin:$HOME/bin:$PATH"
export NODE_PATH="/Users/james/.homebrew/lib/node"

# GPG
if [ -f ~/.gpg-agent-info ]; then
  source ~/.gpg-agent-info
fi

# Boot chruby
if [ -s /usr/local/share/chruby/chruby.sh ] ; then source '/usr/local/share/chruby/chruby.sh'; fi
if [ -s /usr/local/share/chruby/auto.sh ] ; then source '/usr/local/share/chruby/auto.sh'; fi

# Boot nvm
export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh
export PATH="bin:.bundle/bin:node_modules/.bin:$PATH"

if [ -f ~/.amazonrc ]; then
  source ~/.amazonrc
fi

# Print time details for long-running commands
# See http://nuclearsquid.com/writings/reporttime-in-zsh/
export REPORTTIME=10
export FZF_DEFAULT_COMMAND='ag -g ""'

save_function()
{
  local ORIG_FUNC="$(declare -f $1)"
  local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
  eval "$NEWNAME_FUNC"
}

save_function chruby old_chruby

chruby() {
  old_chruby $*
  PATH=bin:.bundle/bin:$PATH
}
