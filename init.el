
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(unless (and (file-exists-p "~/.emacs.d/elpa/archives/gnu")
             (file-exists-p "~/.emacs.d/elpa/archives/melpa"))
  (package-refresh-contents))


;; Init packages now instead of after init.el is loaded
(setq package-enable-at-startup nil)
(package-initialize)

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
;; Packages and whatnot

(ensure-package-installed 'cl-lib)

(ensure-package-installed 'ido)
(ensure-package-installed 'ido-completing-read+)
(require 'setup-ido)

(ensure-package-installed 'dash)
(ensure-package-installed 'dired-single)
(require 'setup-dired)

(ensure-package-installed 'magit)
(eval-after-load 'magit '(require 'setup-magit))

;; TODO Examine
;;(eval-after-load 'shell '(require 'setup-shell))

(ensure-package-installed 'color-theme)
(require 'setup-color-theme)

;; TODO Examine
;;(require 'setup-hippie)

(ensure-package-installed 'yasnippet)
(require 'setup-yasnippet)

;; TODO Examine
;;(require 'setup-perspective)

(ensure-package-installed 'find-file-in-project)
(require 'setup-ffip)

(ensure-package-installed 'ibuffer)
(require 'setup-ibuffer)

;; TODO Get this to install from melpa-stable
;; Pinning doesn't seem to work either
;;(ensure-package-installed 'cider 'melpa-stable)
(require 'setup-cider)

;; TODO Examine
;;(require 'setup-android-mode)

(ensure-package-installed 'undo-tree)
(require 'setup-undo-tree)

(ensure-package-installed 'ag)
(ensure-package-installed 'wgrep-ag)
(require 'setup-ag)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes

;;(ensure-package-installed 'aggressive-indent-mode)

(ensure-package-installed 'tagedit)
(require 'setup-html-mode)

(require 'setup-linum-mode)

(ensure-package-installed 'org)
(require 'setup-org)

;; 3/23 disabled to try web-mode, mostly for es6
;;(require 'setup-js2-mode)
;;(require 'js2-refactor)

(ensure-package-installed 'flycheck)
(require 'setup-flycheck)

(ensure-package-installed 'web-mode)
(require 'setup-web-mode)

(ensure-package-installed 'ruby-mode)
(eval-after-load 'ruby-mode '(require 'setup-ruby-mode))
;;(eval-after-load 'ruby-mode '(require 'ruby-mode-indent-fix))

(ensure-package-installed 'haml-mode)

(ensure-package-installed 'clojure-mode)
(ensure-package-installed 'clj-refactor)
(require 'setup-clojure-mode)

(ensure-package-installed 'markdown-mode)
(require 'setup-markdown-mode)

(ensure-package-installed 'erlang)
(require 'setup-erlang-mode)

(ensure-package-installed 'coffee-mode)
(require 'setup-coffee-mode)

(ensure-package-installed 'scss-mode)
(require 'setup-scss-mode)

(ensure-package-installed 'paredit)
(require 'setup-paredit)

(ensure-package-installed 'company)
(require 'setup-company-mode)

(ensure-package-installed 'sql)
(require 'setup-sql-mode)

(ensure-package-installed 'elixir-mode)
(require 'setup-elixir-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defuns

 (setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
 (dolist (file (directory-files defuns-dir t "\\w+"))
   (when (file-regular-p file)
     (load file)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages

(ensure-package-installed 'anzu)
(require 'setup-anzu)

(ensure-package-installed 'expand-region)
(require 'expand-region)

(ensure-package-installed 'multiple-cursors)
(require 'multiple-cursors)

(ensure-package-installed 'wgrep)
(require 'wgrep)

(ensure-package-installed 'clj-refactor)
(require 'setup-clj-refactor)

(ensure-package-installed 'guide-key)
(require 'setup-guide-key)

;; Fill column indicator

;;(ensure-package-installed 'fill-column-indicator)
;;(require 'fill-column-indicator)
;;(setq fci-rule-color "#111122")

;; Browse kill ring

(ensure-package-installed 'browse-kill-ring)
(require 'browse-kill-ring)
(setq browse-kill-ring-quit-action 'save-and-restore)

;; Smart M-x is smart

(ensure-package-installed 'smex)
(require 'smex)
(smex-initialize)

;; buffer-move

(ensure-package-installed 'buffer-move)
(require 'buffer-move)

;; Diminish modeline clutter

(ensure-package-installed 'diminish)
(require 'diminish)
(diminish 'yas-minor-mode)
(diminish 'abbrev-mode)
(diminish 'anzu-mode)

;; Base exec-path on shell's PATH, mostly for lein and CIDER
;; (and now elixir/mix/erl shims, thus 'x)

(ensure-package-installed 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(ensure-package-installed 'smartscan)
(require 'setup-smartscan)

(ensure-package-installed 'smooth-scrolling)
(require 'smooth-scrolling)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customizations

(require 'my-defaults)
(require 'my-mode-mappings)
(require 'my-key-bindings)
(require 'my-appearance)
(require 'my-misc)
(when is-mac (require 'my-mac))
(when is-linux (require 'my-linux))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customize

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(company-show-numbers t)
 '(css-indent-level 2)
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(exec-path-from-shell-arguments nil)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(mouse-wheel-progressive-speed t)
 '(package-selected-packages
   (quote
    (sql-indent elixir-mode cider clojure-mode multiple-cursors paredit yaml-mode smooth-scrolling smartscan exec-path-from-shell diminish buffer-move smex browse-kill-ring guide-key expand-region anzu company scss-mode coffee-mode erlang markdown-mode tagedit wgrep-ag web-mode undo-tree ido-completing-read+ haml-mode flycheck find-file-in-project dired-single color-theme-solarized color-theme-modern clj-refactor ag)))
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:inherit company-tooltip :background "#1c1c1c"))))
 '(company-scrollbar-fg ((t (:background "#7f8c8d"))))
 '(company-tooltip ((t (:background "#222" :foreground "#888"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :foreground "#ddd"))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :foreground "#c0392b"))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "#444")))))
