;; -*- no-byte-compile: t; -*-
;;; lazyatom/ruby/packages.el

;; Replace rspec and minitest modes with my own test runners
;; that are smarter about using `bin/rails'
(package! rspec-mode :disable t)
(package! minitest :disable t)

(package! feature-mode)
