 ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "James Adam"
  user-mail-address "james@lazyatom.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 14))
;; (setq doom-font (font-spec :family "JetBrains Mono" :size 12))
;; (setq doom-font (font-spec :family "Source Code Pro" :size 12))
(setq doom-font (font-spec :family "Fira Code" :size 12))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Make Emacs fullscreen
(after! evil
  (toggle-frame-maximized))

;; Some defaults
(setq-default
  uniquify-buffer-name-style 'forward
  window-combination-resize t
  evil-vsplit-window-right t ;; when vspliting, the new window is on the right
  evil-split-window-below t ;; when splitting, the new window is on the bottom
  )

;; After spliting, prompt to load another file from the project
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/projectile-find-file))

(setq +ivy-buffer-preview t)

(when IS-MAC
  ;; Smooth scrollings
  ;; (setq mac-mouse-wheel-smooth-scroll t)

  ;; We still need the option key to type things like # on the UK keyboard
  (setq mac-option-modifier nil)
  ;; Make the right alt key available as meta in case that's useful
  (setq mac-right-option-modifier 'meta)

  ;; I can't get any other auth sources worker it seems. TODO: fix this to be secure.
  (setq auth-sources '("~/.authinfo"))

  ;; Return to normal mode after saving using cmd-s
  (map! "s-s" (lambda nil (interactive) (evil-force-normal-state) (save-buffer))))

;; Include underscore in word movement commands for Evil mode
(after! evil
  (dolist (mode-hook '(ruby-mode-hook enh-ruby-mode-hook python-mode-hook js2-mode-hook haml-mode-hook web-mode-hook))
    (add-hook mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))))

;; Projectile can automatically load projects from these directories
(setq projectile-project-search-path
  `("~/Code/exciting" "~/Code/lazyatom" "~/Code/mubi" "~/Code/experiments" "~/Code/forks"))

;; Magit configuration
(map!
  :leader
  (:prefix "g"
    ;; swap blame and branch checkout -- I blame _far_ more often than changing branch
    :desc "Git blame" "b" 'magit-blame-addition
    :desc "Switch branch" "B" 'magit-branch-checkout

    ;; Spacemacs muscle memory
    ;; :desc "Git status" "s" 'magit-status
    ;; :desc "Magit popup" "m" 'magit-dispatch

    ;; :desc "Git log" "l" 'magit-log
    :desc "Git pull" "p" 'magit-pull
    )
  )

;; redefine cmd-<n> to switch windows, not workspaces

(map!
  :map (evil-normal-state-map evil-insert-state-map evil-visual-state-map)
  "s-0"   #'winum-select-window-0-or-10
  "s-1"   #'winum-select-window-1
  "s-2"   #'winum-select-window-2
  "s-3"   #'winum-select-window-3
  "s-4"   #'winum-select-window-4
  "s-5"   #'winum-select-window-5
  "s-6"   #'winum-select-window-6
  "s-7"   #'winum-select-window-7
  "s-8"   #'winum-select-window-8
  "s-9"   #'winum-select-window-9
  )


;; General key mapping to match what I'm used to
(map!
  "s-[" 'projectile-previous-project-buffer
  "s-]" 'projectile-next-project-buffer

  ;; use evil-surround on 's', rather than evil-snipe
  :v "s" #'evil-surround-region

  ;; indent using tab in visual mode
  :v "TAB" #'evil-indent

  :leader
  :n "0" #'winum-select-window-0-or-10
  :n "1" #'winum-select-window-1
  :n "2" #'winum-select-window-2
  :n "3" #'winum-select-window-3
  :n "4" #'winum-select-window-4
  :n "5" #'winum-select-window-5
  :n "6" #'winum-select-window-6
  :n "7" #'winum-select-window-7
  :n "8" #'winum-select-window-8
  :n "9" #'winum-select-window-9

  :desc "Search project" :g "/" #'+default/search-project

  (:prefix "p"
    :desc "Open alternate file in a new window" :g "A" 'projectile-find-implementation-or-test-other-window
    )

  ;; Manage workspaces under a "layout" prefix
  (:prefix-map ("l" . "layout")
    :n "0" #'+workspace/switch-to-9
    :n "1" #'+workspace/switch-to-0
    :n "2" #'+workspace/switch-to-1
    :n "3" #'+workspace/switch-to-2
    :n "4" #'+workspace/switch-to-3
    :n "5" #'+workspace/switch-to-4
    :n "6" #'+workspace/switch-to-5
    :n "7" #'+workspace/switch-to-6
    :n "8" #'+workspace/switch-to-7
    :n "9" #'+workspace/switch-to-8
    :n "x" #'+workspace/delete
    :n "n" #'+workspace/new
    )

  ;; :prefix "w"
  ;; "/" 'evil-window-vsplit
  ;; "-" 'evil-window-split

  ;; insert newlines above and below
  (:prefix-map ("i" . "insert")
    :n "k" #'+evil/insert-newline-above
    :n "j" #'+evil/insert-newline-below
    )

  ;; search buffer for thing at point
  (:prefix "s"
    :desc "Search buffer for thing at point"
    :n "S" #'swiper-thing-at-point
    )

  :g "T" #'treemacs

  ;; toggle the last popup, e.g. compile
  :g "§" #'+popup/toggle

  )

;; match Spacemacs commit keys
(map!
  :map git-commit-mode-map
  :prefix ","
  :n "," #'with-editor-finish
  :n "k" #'with-editor-cancel)

;; open magit in a new window
(after! magit
  (setq magit-display-buffer-function #'magit-display-buffer-traditional))

;; wrap compilation output
(defun my-compilation-mode-hook ()
  (setq truncate-lines nil) ;; automatically becomes buffer local
  (set (make-local-variable 'truncate-partial-width-windows) nil))
(add-hook 'compilation-mode-hook 'my-compilation-mode-hook)

(setq org-roam-directory "~/Dropbox/Documents/org-roam")

(after! org-roam
  (map! :leader
    :prefix "n"
    :desc "org-roam" "l" #'org-roam
    :desc "org-roam-insert" "i" #'org-roam-insert
    :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
    :desc "org-roam-find-file" "f" #'org-roam-find-file
    :desc "org-roam-show-graph" "g" #'org-roam-show-graph
    :desc "org-roam-insert" "i" #'org-roam-insert
    :desc "org-roam-capture" "c" #'org-roam-capture))

;; Bind ivy-restrict-to-matches
;; (map! :map ivy-minibuffer-map
;;   "S-SPC" nil
;;   "C-f" 'ivy-restrict-to-matches)

;; Show a hydra when looking at actions on an ivy minibuffer
;; (setq ivy-read-action-function #'ivy-hydra-read-action)

;; Markdown stuff
(setq markdown-toc-header-toc-title "\n## Table of Contents")
;; (add-hook! (gfm-mode markdown-mode) #'mixed-pitch-mode)
;; (add-hook! (gfm-mode markdown-mode) #'visual-line-mode #'turn-off-auto-fill)
;; (custom-set-faces!
;;   '(markdown-header-face-1 :height 1.25 :weight extra-bold :inherit markdown-header-face)
;;   '(markdown-header-face-2 :height 1.15 :weight bold       :inherit markdown-header-face)
;;   '(markdown-header-face-3 :height 1.08 :weight bold       :inherit markdown-header-face)
;;   '(markdown-header-face-4 :height 1.00 :weight bold       :inherit markdown-header-face)
;;   '(markdown-header-face-5 :height 0.90 :weight bold       :inherit markdown-header-face)
;;   '(markdown-header-face-6 :height 0.75 :weight extra-bold :inherit markdown-header-face))
