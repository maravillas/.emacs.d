
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-level 2)
 '(css-indent-offset 2)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(sql-mysql-program "/usr/local/mysql/bin/mysql")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify)))

;; Set path to dependencies

(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; Set up load path

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path (expand-file-name "setups" user-emacs-directory))

;; Settings for currently logged in user

(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

;; Add external projects to load path

(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Default the font size to 11pt

(set-face-attribute 'default nil :height 110)

;; (setq frame-title-format '("" "%b - Emacs " emacs-version))

;; Save point position between sessions

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Are we on a mac?

(setq is-mac (equal system-type 'darwin))

;; Packages

(require 'setup-package)

(require 'sane-defaults)

;; Set up environment variables from the user's shell.

(when is-mac (exec-path-from-shell-initialize))

;; Set up extensions

(eval-after-load 'ido '(require 'setup-ido))
(eval-after-load 'org '(require 'setup-org))
(eval-after-load 'dired '(require 'setup-dired))
(eval-after-load 'magit '(require 'setup-magit))
;; (eval-after-load 'grep '(require 'setup-rgrep))
(eval-after-load 'shell '(require 'setup-shell))
(require 'setup-color-theme)
(require 'setup-hippie)
(require 'setup-yasnippet)
(require 'setup-perspective)
(require 'setup-ffip)
(require 'setup-html-mode)
(require 'setup-linum-mode)
(require 'setup-ibuffer)
(require 'setup-nrepl)

;; Language setup

(eval-after-load 'js2-mode '(require 'setup-js2-mode))
(eval-after-load 'ruby-mode '(require 'setup-ruby-mode))
(eval-after-load 'clojure-mode '(require 'setup-clojure-mode))
(eval-after-load 'markdown-mode '(require 'setup-markdown-mode))
(require 'coffee-mode)

(require 'setup-paredit)

(require 'mode-mappings)

;; Functions (load all files in defuns-dir)

(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require 'expand-region)
(require 'multiple-cursors)
(require 'wgrep)

;; Fill column indicator

(require 'fill-column-indicator)
(setq fci-rule-color "#111122")

;; Browse kill ring

(require 'browse-kill-ring)
(setq browse-kill-ring-quit-action 'save-and-restore)

;; Smart M-x is smart

(require 'smex)
(smex-initialize)

;; buffer-move

(require 'buffer-move)

;; Setup key bindings

(require 'key-bindings)

;; Misc

(require 'appearance)

(require 'misc)

(when is-mac (require 'mac))

;; Diminish modeline clutter
;; FIXME
;; (require 'diminish)
;; (diminish 'yas/minor-mode)

;; Elisp go-to-definition with M-. and back again with M-,

(autoload 'elisp-slime-nav-mode "elisp-slime-nav")
(add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t)))
(eval-after-load 'elisp-slime-nav '(diminish 'elisp-slime-nav-mode))

;; Emacs server

;; (require 'server)
;; (unless (server-running-p)
;;  (server-start))

;; Run at full power please

(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Conclude init by setting up specifics for the current user

(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))










;; merge below into new setup


;; js2-mode

;;(autoload 'js-mode "js")

;; (custom-set-variables '(slime-net-coding-system (quote utf-8-unix)))

