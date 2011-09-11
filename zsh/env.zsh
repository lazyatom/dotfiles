RIPDIR=~/.rip
RUBYLIB="$RUBYLIB:$RIPDIR/active/lib"
RBENVDIR="$HOME/.rbenv"
PATH="/Users/james/.homebrew/sbin:/Users/james/.homebrew/bin:$HOME/.homebrew/share/npm/bin:$HOME/bin:$RIPDIR/active/bin:$HOME/.bundle/ruby/1.8/bin:$RBENVDIR/bin:$PATH"
NODE_PATH="/Users/james/.homebrew/lib/node"
export RIPDIR RUBYLIB PATH NODE_PATH RBENVDIR

# GPG
if [ -f ~/.gpg-agent-info ]; then
  source ~/.gpg-agent-info
fi

# RVM installer added line:
#if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi

# Boot rbenv if it exists
if [ -s ~/.rbenv ] ; then eval "$(rbenv init -)" ; fi

# Pratik's recommended ruby performance settings
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000

if [ -f ~/.amazonrc ]; then
  source ~/.amazonrc
fi