;; Slightly faster startup
(package-initialize)
(setq package-enable-at-startup nil)

(setq custom-file "~/.emacs.d/customize.el")
(load custom-file t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load paths

(setq site-lisp-dir (expand-file-name "site-lisp" user-emacs-directory))

(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path (expand-file-name "setup" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "my" user-emacs-directory))

;; Add path to non-ELPA-installed projects

(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flags

(setq is-mac (equal system-type 'darwin))
(setq is-linux (equal system-type 'gnu/linux))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre-package configuration

(require 'setup-package)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Libraries

(use-package dash)
(use-package diminish)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages and whatnot

(use-package ido
  :config (require 'setup-ido))
(use-package ido-completing-read+
  :after (ido)
  :config (require 'setup-ido-completing-read))

(use-package dired-single)

(use-package magit
  :config (require 'setup-magit))

(use-package yasnippet
  :diminish yas-minor-mode
  :config (require 'setup-yasnippet))

;; Consider dropping for perspective and/or helm?
(use-package find-file-in-project
  :config (require 'setup-ffip))

(use-package ibuffer
  :config (require 'setup-ibuffer))

(use-package cider
  :config (require 'setup-cider))

(use-package undo-tree
  :diminish undo-tree-mode
  :config (require 'setup-undo-tree))

(use-package tagedit
  :config (require 'setup-tagedit))

(use-package anzu
  :diminish anzu-mode
  :config (require 'setup-anzu))

(use-package multiple-cursors)

(use-package wgrep)

(use-package guide-key
  :config (require 'setup-guide-key))

(use-package browse-kill-ring
  :config (setq browse-kill-ring-quit-action 'save-and-restore))

(use-package smex
  :config (smex-initialize))

(use-package buffer-move)

;; Base exec-path on shell's PATH, mostly for lein and CIDER
;; (and now elixir/mix/erl shims, thus 'x)
(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
	    (exec-path-from-shell-initialize)))

;; Other packages to consider: hydra, perspective, helm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes

(use-package org
  :config (require 'setup-org))

(use-package flycheck
  :config (require 'setup-flycheck))

(use-package web-mode
  :config (require 'setup-web-mode))

(use-package ruby-mode
  :config (require 'setup-ruby-mode))

(use-package clojure-mode
  :config (require 'setup-clojure-mode))

(use-package clj-refactor
  :after (clojure-mode)
  :config (require 'setup-clj-refactor))

(use-package markdown-mode
  :config (require 'setup-markdown-mode))

(use-package erlang
  :config (require 'setup-erlang-mode))

(use-package elixir-mode
  :config (require 'setup-elixir-mode))

(use-package scss-mode
  :config (require 'setup-scss-mode))

(use-package paredit
  :config (require 'setup-paredit))

(use-package company
  :config (require 'setup-company-mode))

(use-package sql
  :config (require 'setup-sql-mode))

(use-package smartscan
  :config (require 'setup-smartscan))

(use-package smooth-scrolling)

(use-package rg
  :config (require 'setup-rg))

(require 'setup-dired)

(require 'setup-occur)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defuns

 (setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
 (dolist (file (directory-files defuns-dir t "\\w+"))
   (when (file-regular-p file)
     (load file)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customizations

(require 'my-appearance)
(require 'my-mode-mappings)
(require 'my-key-bindings)
(require 'my-appearance)
(require 'my-misc)

(when is-mac (require 'my-mac))
(when is-linux (require 'my-linux))
