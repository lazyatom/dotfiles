bindkey '^H' backward-delete-char
bindkey "^[[3~" delete-char
setopt autocd

# Always use emacs mode, regardless of the EDITOR
bindkey -e

# By default these are meta-B/F, but I prefer ctrl.
bindkey '^b' emacs-backward-word
bindkey '^f' emacs-forward-word