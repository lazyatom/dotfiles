;;; lazyatom/ruby/config.el -*- lexical-binding: t; -*-

(map!
 :after ruby-mode
 :localleader
 :map (projectile-rails-mode-map ruby-mode-map)

 (:prefix "b"
  :desc "bundle-open (new workspace)" "o" #'lazyatom/bundle-open-in-new-workspace
  "O" #'bundle-open
  )

 (:prefix ("t" . "test")
  "r" 'lazyatom/test-file
  "t" 'lazyatom/test-single
  "e" 'lazyatom/test-recent
  "h" 'lazyatom/test-select-from-history
  "d" 'lazyatom/test-debug
  "b" 'lazyatom/toggle-backtrace
  "s" 'lazyatom/toggle-spring
  "c" 'lazyatom/toggle-show-system-test-chrome

  (:prefix ("p" . "profile")
   "d" 'lazyatom/profiling-disabled
   "f" 'lazyatom/profiling-flat-mode
   "l" 'lazyatom/profiling-flat-with-line-numbers-mode
   "g" 'lazyatom/profiling-graph-mode
   "h" 'lazyatom/profiling-graph-html-mode
   "t" 'lazyatom/profiling-call-tree-mode
   "s" 'lazyatom/profiling-stack-mode
   )

  (:prefix ("T" . "toggle")
   "b" 'lazyatom/toggle-backtrace
   "c" 'lazyatom/toggle-show-system-test-chrome
   "p" 'lazyatom/profiling-disabled
   )
  )
 )
