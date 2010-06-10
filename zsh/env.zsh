RIPDIR=~/.rip
RUBYLIB="$RUBYLIB:$RIPDIR/active/lib"
PATH="$HOME/bin:$RIPDIR/active/bin:$HOME/.bundle/ruby/1.8/bin:$PATH"
export RIPDIR RUBYLIB PATH

# GPG
if [ -f ~/.gpg-agent-info ]; then
  source ~/.gpg-agent-info
fi

# RVM installer added line:
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi

# Pratik's recommended ruby performance settings
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000