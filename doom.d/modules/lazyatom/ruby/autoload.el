;;; lazyatom/ruby/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defvar lazyatom/last-test-command
  nil
  "The last test command we ran")

;;;###autoload
(defvar lazyatom/test-history
  nil
  "A list of previous test commands")

;;;###autoload
(defun lazyatom/add-to-test-history (test-command)
  (set 'lazyatom/test-history (cons test-command (delete test-command lazyatom/test-history)))
  "Add an item to the test history")

;;;###autoload
(defun lazyatom/activate-project-versions ()
  (chruby-use-corresponding)
  )

;;;###autoload
(defvar lazyatom/use-spring
  nil
  "Whether or not to use spring to run tests"
  )

;;;###autoload
(defvar lazyatom/show-backtrace
  nil
  "Whether or not to show full backtraces for errors"
  )

;; (defvar lazyatom/run-profiling
;;   nil
;;   "Whether or not to run profiling against the tests"
;;   )

;;;###autoload
(defvar lazyatom/profiling-mode
  nil
  "Profiling mode to use"
  )

;;;###autoload
(defvar lazyatom/show-system-test-chrome
  nil
  "Show the Chrome browser when running system tests"
  )

;;;###autoload
(defun lazyatom/toggle-spring ()
  (interactive)
  (if lazyatom/use-spring
      (progn (set 'lazyatom/use-spring nil)
             (message "Spring is now disabled"))
    (progn (set 'lazyatom/use-spring t)
           (message "Spring is now enabled"))
    )
  )

;;;###autoload
(defun lazyatom/toggle-backtrace ()
  (interactive)
  (if lazyatom/show-backtrace
      (progn (set 'lazyatom/show-backtrace nil)
             (message "Backtrace display is now disabled"))
    (progn (set 'lazyatom/show-backtrace t)
           (message "Backtrace display is now enabled"))
    )
  )

;;;###autoload
(defun lazyatom/toggle-show-system-test-chrome ()
  (interactive)
  (if lazyatom/show-system-test-chrome
    (progn (set 'lazyatom/show-system-test-chrome nil)
      (message "Showing Chrome in system tests is now disabled"))
    (progn (set 'lazyatom/show-system-test-chrome t)
      (message "Showing Chrome in system tests is now enabled"))
    )
  )

;;;###autoload
(defun lazyatom/profiling-disabled ()
  (interactive)
  (progn (set 'lazyatom/profiling-mode nil)
    (message "Profiling mode disabled"))
  )

;;;###autoload
(defun lazyatom/profiling-flat-mode ()
  (interactive)
  (progn (set 'lazyatom/profiling-mode "flat")
    (message "Profiling mode set to flat"))
  )

;;;###autoload
(defun lazyatom/profiling-flat-with-line-numbers-mode ()
  (interactive)
  (progn (set 'lazyatom/profiling-mode "flat_line_numbers")
    (message "Profiling mode set to flat with line numbers"))
  )

;;;###autoload
(defun lazyatom/profiling-graph-mode ()
  (interactive)
  (progn (set 'lazyatom/profiling-mode "graph")
    (message "Profiling mode set to graph"))
  )

;;;###autoload
(defun lazyatom/profiling-graph-html-mode ()
  (interactive)
  (progn (set 'lazyatom/profiling-mode "graph_html")
    (message "Profiling mode set to graph html"))
  )

;;;###autoload
(defun lazyatom/profiling-call-tree-mode ()
  (interactive)
  (progn (set 'lazyatom/profiling-mode "call_tree")
    (message "Profiling mode set to call tree"))
  )

;;;###autoload
(defun lazyatom/profiling-stack-mode ()
  (interactive)
  (progn (set 'lazyatom/profiling-mode "call_stack")
    (message "Profiling mode set to call stack"))
  )

;;;###autoload
(defun lazyatom/run-test-command (command)
  (projectile-with-default-dir (projectile-project-root)
    (lazyatom/activate-project-versions)
    ;; (set 'lazyatom/last-test-command command)
    (ansi-color-for-comint-mode-on)
    (let ((compilation-scroll-output t)))
    (compile (concat (lazyatom/run-wrapper) command) t)
    )
  )

;;;###autoload
(defun lazyatom/test-type-for (file-path)
  (if (s-suffix? "_spec.rb" file-path)
      (quote rspec)
    (if (s-suffix? "_test.rb" file-path)
          (quote rails)
      (if (s-suffix? ".feature" file-path)
          (quote cucumber)
        (quote ruby)
        )
      )
    )
  )

;;;###autoload
(defun lazyatom/run-wrapper ()
  (concat
    (if lazyatom/show-backtrace "BACKTRACE=true " "")
    (if lazyatom/profiling-mode (concat "TEST_RUBY_PROF=" lazyatom/profiling-mode " ") "")
    (if lazyatom/show-system-test-chrome "SHOW_SYSTEM_TEST_CHROME=true " lazyatom/profiling-mode "")
    (if lazyatom/use-spring "bundle exec spring " "bundle exec ")
    )
  )

;;;###autoload
(defun lazyatom/exec-runner-for (file-path)
  (pcase (lazyatom/test-type-for file-path)
    ;; ('rails    (concat (lazyatom/run-wrapper) "rails test"))
    ;; ('rspec    (concat (lazyatom/run-wrapper) "rspec"))
    ;; ('cucumber (concat (lazyatom/run-wrapper) "cucumber"))
    ;; ('ruby     (concat (lazyatom/run-wrapper) "ruby -Itest"))
    ('rails    "rails test")
    ('rspec    "rspec")
    ('cucumber "cucumber")
    ('ruby     "ruby -Itest")
    )
  )

;;;###autoload
(defun lazyatom/test-command-for (file-path)
  (format "%s %s" (lazyatom/exec-runner-for file-path) file-path)
  )

;;;###autoload
(defun lazyatom/test-command-with-line-for (file-path line-number)
  (format "%s %s:%s" (lazyatom/exec-runner-for file-path) file-path line-number)
  )

;;;###autoload
(defun lazyatom/test-file ()
  (interactive)
  (lazyatom/add-to-test-history (lazyatom/test-command-for buffer-file-name))
  (set 'lazyatom/last-test-command (lazyatom/test-command-for buffer-file-name))
  (lazyatom/run-test-command (lazyatom/test-command-for buffer-file-name))
  )

;;;###autoload
(defun lazyatom/test-single ()
  (interactive)
  (lazyatom/add-to-test-history (lazyatom/test-command-with-line-for buffer-file-name (line-number-at-pos (point))))
  (set 'lazyatom/last-test-command (lazyatom/test-command-with-line-for buffer-file-name (line-number-at-pos (point))))
  (lazyatom/run-test-command(lazyatom/test-command-with-line-for buffer-file-name (line-number-at-pos (point))))
  )

;;;###autoload
(defun lazyatom/test-recent ()
  (interactive)
  (lazyatom/run-test-command lazyatom/last-test-command)
  )

;;;###autoload
(defun lazyatom/test-select-from-history()
  (interactive)
  (ivy-read "Select test command: "
    lazyatom/test-history
    ;; :keymap counsel-describe-map
    ;; :preselect (ivy-thing-at-point)
    :history 'lazyatom-test-select-from-history-history
    :require-match t
    :action (lambda (x)
              (lazyatom/run-test-command x)
              )
    :caller 'lazyatom/test-select-from-history))

;;;###autoload
(defun lazyatom/test-debug ()
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (chruby-use-corresponding)
    (compile (format "chruby; which ruby; ruby -v; bundle exec ruby -v; pwd; echo 'Projectile project root: %s'" (projectile-project-root)))
    )
  )

;;;###autoload
(defun lazyatom/bundle-open-in-new-workspace (gem-name)
  "Queries for a gem name and opens the location of the gem in dired, in a new workspace."
  (interactive (list (completing-read "Bundled gem: " (bundle-list-gems-cached))))
    (if (= (length gem-name) 0)
        (message "No gem name given.")
      (let ((gem-location (bundle-gem-location gem-name)))
        (cond
         ((eq gem-location 'no-gemfile)
          (message "Could not find Gemfile"))
         (gem-location
          (+workspace/new gem-name nil)
          ;; (+workspace/switch-to-final)
          (dired gem-location))
         (t
          (message "Gem '%s' not found" gem-name))))))
