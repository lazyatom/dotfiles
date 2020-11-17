# function hybrid_bindings --description "Vi-style bindings that inherit emacs-style bindings in all modes"
#     for mode in default insert visual
#         fish_default_key_bindings -M $mode
#     end
#     fish_vi_key_bindings --no-erase
# end
# set -g fish_key_bindings hybrid_bindings

set -gx TERM screen-256color
set -g theme_display_date no

abbr --add edit emacsclient -n

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

function fish_title
  true
end

set -gx EDITOR emacsclient
