
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

;; packages

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Bleeding edge

;;(add-to-list 'package-archives
;;             '("marmalade" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

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
(require 'setup-paredit)
(require 'setup-linum-mode)

;; Language setup

(eval-after-load 'js2-mode '(require 'setup-js2-mode))
(eval-after-load 'ruby-mode '(require 'setup-ruby-mode))
(eval-after-load 'clojure-mode '(require 'setup-clojure-mode))
(eval-after-load 'markdown-mode '(require 'setup-markdown-mode))
(require 'coffee-mode)

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


;; Backup file naming

(defun make-backup-file-name (FILE)                                             
  (let ((dirname (concat "~/.backups/emacs/"                                    
                         (format-time-string "%y/%m/%d/"))))                    
    (if (not (file-exists-p dirname))                                           
        (make-directory dirname t))                                             
    (concat dirname (file-name-nondirectory FILE))))

;; js2-mode

;;(autoload 'js-mode "js")


;; ido

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; scss-mode

(require 'scss-mode)

;------ clojure-test-mode ------;
	    
;; (autoload 'clojure-test-mode "clojure-test-mode" "\
;; A minor mode for running Clojure tests.

;; \(fn &optional ARG)" t nil)

;; (defun clojure-test-maybe-enable nil "\
;; Enable clojure-test-mode if the current buffer contains Clojure tests.
;; Also will enable it if the file is in a test directory." (save-excursion (goto-char (point-min)) (if (or (search-forward "(deftest" nil t) (search-forward "(with-test" nil t) (string-match "/test/$" default-directory)) (clojure-test-mode t))))

;; (add-hook 'clojure-mode-hook 'clojure-test-maybe-enable)

;; lazy-test indention

(eval-after-load 'clojure-mode
  '(define-clojure-indent
     (describe 'defun)
     (testing 'defun)
     (given 'defun)
     (using 'defun)
     (with 'defun)
     (it 'defun)
     (do-it 'defun)))

;; SLIME

(defun my-slime-repl-mode-hook ()
  (local-set-key "\C-c\C-s" 'slime-selector)
  (def-slime-selector-method ?j
    "most recently visited clojure-mode buffer."
    (slime-recently-visited-buffer 'clojure-mode)))
    
(add-hook 'slime-repl-mode-hook 'my-slime-repl-mode-hook)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

(defun fix-paredit-repl ()
  (interactive)
  (local-set-key "{" 'paredit-open-curly)
  (local-set-key "}" 'paredit-close-curly)
  (modify-syntax-entry ?\{ "(}") 
  (modify-syntax-entry ?\} "){")
  (modify-syntax-entry ?\[ "(]")
  (modify-syntax-entry ?\] ")["))

(fix-paredit-repl)

;; elein

(require 'elein)

;; ibuffer

(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("js" (mode . js2-mode))
               ("ejs" (name . "\.ejs$"))
               ("magit" (name . "^\\*magit"))
               ("emacs" (name . "^\\*.*\\*$"))
               ("clj" (name . "\.clj$"))
               ("cljs" (name . "\.cljs$"))
               ("css" (name . "\.css$"))
               ("org" (mode . org-mode))
               ("xml" (mode . nxml-mode))
               ("java" (mode . java-mode))
               ("controllers" (name . "/controllers/"))
               ("models" (name . "/models/"))
               ("views" (name . "/views/"))
               ("migrations" (name . "/db/migrate/"))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; (define-ibuffer-sorter filename-or-dired
;;   "Sort the buffers by their pathname."
;;   (:description "filenames plus dired")
;;   (string-lessp 
;;    (with-current-buffer (car a)
;;      (or buffer-file-name
;;          (if (eq major-mode 'dired-mode)
;;              (expand-file-name dired-directory))
;;          ;; so that all non pathnames are at the end
;;          "~"))
;;    (with-current-buffer (car b)
;;      (or buffer-file-name
;;          (if (eq major-mode 'dired-mode)
;;              (expand-file-name dired-directory))
;;          ;; so that all non pathnames are at the end
;;          "~"))))

;; (define-key ibuffer-mode-map (kbd "s p")     'ibuffer-do-sort-by-filename-or-dired)

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

;; uniquify

(require 'uniquify)

;; sqli

(defun sql-add-newline-first (output)
  "Add newline to beginning of OUTPUT for `comint-preoutput-filter-functions'"
  (concat "\n" output))
(defun sqli-add-hooks ()
  "Add hooks to `sql-interactive-mode-hook'."
  (add-hook 'comint-preoutput-filter-functions
            'sql-add-newline-first))
(add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)

;; slamhound

(defun slamhound ()
  (interactive)
  (let ((result (first (slime-eval `(swank:eval-and-grab-output
                                      (format "(do (require 'slam.hound)
                                                 (slam.hound/reconstruct \"%s\"))"
                                              ,buffer-file-name))))))
    (goto-char (point-min))
    (kill-sexp)
    (insert result)))

;; android.el

(add-to-list 'load-path "~/android-sdks/tools/lib")
(require 'android)

;; android-mode

(require 'android-mode)

;; Key customizations

(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

(setq column-number-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Disable some beeps

(defun my-bell-function ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")

;; (custom-set-variables '(slime-net-coding-system (quote utf-8-unix)))

;; buffer-move
(require 'buffer-move)

;; nrepl
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
