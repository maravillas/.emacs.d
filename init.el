
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

;; Setup load path

(add-to-list 'load-path user-emacs-directory)

;; Default the font size to 11pt

(set-face-attribute 'default nil :height 110)

(setq frame-title-format '("" "%b - Emacs " emacs-version))

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

;; Bleeding edge (git head for nrepl, and others?)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2)))

(setq font-lock-verbose nil)

(tool-bar-mode 0)

;; magit

(setq magit-git-executable "/usr/bin/git")

;; Backup file naming

(defun make-backup-file-name (FILE)                                             
  (let ((dirname (concat "~/.backups/emacs/"                                    
                         (format-time-string "%y/%m/%d/"))))                    
    (if (not (file-exists-p dirname))                                           
        (make-directory dirname t))                                             
    (concat dirname (file-name-nondirectory FILE))))

;; clojure-mode

(require 'clojure-mode)

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(require 'clojure-test-mode)

;; org-mode

(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
(setq org-agenda-files (list "~/org/todo.org"))

;; color-theme

;; I forget why, but I think 6.5.5 (in marmalade) didn't work

(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (require 'color-theme-maravillas)
     (color-theme-maravillas)))


;; linum

(require 'linum)
(add-hook 'find-file-hook (lambda () (linum-mode 1)))

;; js2-mode

;(add-to-list 'load-path "~/.emacs.d/js2-mode")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js-indent-level 2)

(autoload 'js-mode "js")

(defun espresso-js2-indent-function ()
 (interactive)
 (save-restriction
   (widen)
   (let* ((inhibit-point-motion-hooks t)
          (parse-status (save-excursion (syntax-ppss (point-at-bol))))
          (offset (- (current-column) (current-indentation)))
          (indentation (js--proper-indentation parse-status))
          node)
     (save-excursion
       (back-to-indentation)
       ;; consecutive declarations in a var statement are nice if
       ;; properly aligned, i.e:
       ;;
       ;; var foo = "bar",
       ;;     bar = "foo";
       (setq node (js2-node-at-point))
       (when (and node
                  (= js2-NAME (js2-node-type node))
                  (= js2-VAR (js2-node-type (js2-node-parent node))))
         (setq indentation (+ 4 indentation))))
     (indent-line-to indentation)
     (when (> offset 0) (forward-char offset)))))

;;(require 'js2-highlight-vars)

(defun espresso-indention-js2-mode-hook ()
  (require 'js)
  (setq espresso-indent-level 2
        indent-tabs-mode nil
        c-basic-offset 2)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'espresso-js2-indent-function)
  
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  
  (if (featurep 'js2-highlight-vars)
      (js2-highlight-vars-mode))
  (message "Espresso-indention for JS2 hook"))

(add-hook 'js2-mode-hook 'espresso-indention-js2-mode-hook)

;; coffee-mode

(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; ido

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; csv-mode
;; not working

(autoload 'csv-mode "csv-mode" "CSV editing mode." t)
(add-to-list 'auto-mode-alist '("\.csv$" . csv-mode))
;(add-to-list 'interpreter-mode-alist '("csv" . csv-mode))

;; paredit

(autoload 'paredit-mode "paredit" t)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
	    (paredit-mode +1)
	    (setq abbrev-mode t)))

(add-hook 'lisp-mode-hook
          (lambda ()
	    (paredit-mode +1)
	    (setq abbrev-mode t)))

(add-hook 'clojure-mode-hook
          (lambda ()
	    (paredit-mode +1)
	    (setq abbrev-mode t)))

(eval-after-load "paredit"
  '(progn
    (define-key paredit-mode-map (kbd ";")   'nil)
    
    (define-key paredit-mode-map (kbd ")")   'paredit-close-parenthesis)
    (define-key paredit-mode-map (kbd "M-)") 'paredit-close-parenthesis-and-newline)
  
    (define-key paredit-mode-map (kbd "{")   'paredit-open-curly)
    (define-key paredit-mode-map (kbd "}")   'paredit-close-curly)

    (define-key paredit-mode-map (kbd "<M-left>") 'paredit-backward-barf-sexp)
    (define-key paredit-mode-map (kbd "<M-right>") 'paredit-forward-slurp-sexp)

    (define-key paredit-mode-map (kbd "<C-left>") 'backward-word)
    (define-key paredit-mode-map (kbd "<C-right>") 'forward-word)))

(define-key clojure-mode-map (kbd "DEL") 'paredit-backward-delete)

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

;; ruby-mode

(add-to-list 'auto-mode-alist '("^Rakefile$" . ruby-mode))
(setq ruby-deep-arglist nil)
(setq ruby-deep-indent-paren nil)

;; html-mode

(add-to-list 'auto-mode-alist '("\\.ejs$" . html-mode))

;; sqli

(defun sql-add-newline-first (output)
  "Add newline to beginning of OUTPUT for `comint-preoutput-filter-functions'"
  (concat "\n" output))
(defun sqli-add-hooks ()
  "Add hooks to `sql-interactive-mode-hook'."
  (add-hook 'comint-preoutput-filter-functions
            'sql-add-newline-first))
(add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)

;; markdown-mode

;;(autoload 'markdown-mode "markdown-mode/markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

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

;; multiple-cursors
(require 'multiple-cursors)

;; nrepl
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)

;; cljsbuild-mode

(require 'cljsbuild-mode)


;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require 'key-bindings)



;; Installed packages:

;; android-mode      0.2.1       installed  Minor mode for Android application development
;; buffer-move       0.4         installed  Swap buffers between windows
;; cljsbuild-mode    0.2.0       installed  A minor mode for the ClojureScript 'lein cljsbuild' command
;; clojure-mode      1.11.5      installed  Major mode for Clojure code
;; clojure-test-mode 1.6.0       installed  Minor mode for Clojure tests
;; clojurescript-mode 0.5        installed  Major mode for ClojureScript code
;; coffee-mode       0.4.1       installed  Major mode for CoffeeScript files
;; csv-mode          1.50        installed  Major mode for editing comma-separated value files
;; elein             0.2.2       installed  Running leiningen commands from emacs
;; find-file-in-git-repo 0.1.2   installed  Utility to find files in a git repo
;; find-file-in-project 3.2      installed  Find files in a project quickly.
;; haml-mode         3.0.14      installed  Major mode for editing Haml files
;; ido-yes-or-no     1.1         installed  Use Ido to answer yes-or-no questions
;; js2-mode          20090814    installed  Improved JavaScript editing mode
;; magit             1.2.0       installed  Control Git from Emacs.
;; magithub          0.2         installed  Magit extensions for using GitHub
;; markdown-mode     1.8.1       installed  Emacs Major mode for Markdown-formatted text files
;; multiple-cursors  1.1.3       installed  Multiple cursors for Emacs.
;; nrepl             0.1.6       installed  Client for Clojure nREPL
;; paredit           22          installed  Minor mode for editing parentheses  -*- Mode: Emacs-Lisp -*-
;; rvm               1.2         installed  Emacs integration for rvm
;; sass-mode         3.0.14      installed  Major mode for editing Sass files
;; scss-mode         0.5.0       installed  Major mode for editing SCSS files
;; slime             20100404.1  installed  Superior Lisp Interaction Mode for Emacs
;; slime-repl        20100404    installed  Read-Eval-Print Loop written in Emacs Lisp
;; yaml-mode         0.0.7       installed  Major mode for editing YAML files  android-mode      0.2.1       installed  Minor mode for Android application development
;; buffer-move       0.4         installed  Swap buffers between windows
;; cljsbuild-mode    0.2.0       installed  A minor mode for the ClojureScript 'lein cljsbuild' command
;; clojure-mode      1.11.5      installed  Major mode for Clojure code
;; clojure-test-mode 1.6.0       installed  Minor mode for Clojure tests
;; clojurescript-mode 0.5        installed  Major mode for ClojureScript code
;; coffee-mode       0.4.1       installed  Major mode for CoffeeScript files
;; csv-mode          1.50        installed  Major mode for editing comma-separated value files
;; elein             0.2.2       installed  Running leiningen commands from emacs
;; find-file-in-git-repo 0.1.2   installed  Utility to find files in a git repo
;; find-file-in-project 3.2      installed  Find files in a project quickly.
;; haml-mode         3.0.14      installed  Major mode for editing Haml files
;; ido-yes-or-no     1.1         installed  Use Ido to answer yes-or-no questions
;; js2-mode          20090814    installed  Improved JavaScript editing mode
;; magit             1.2.0       installed  Control Git from Emacs.
;; magithub          0.2         installed  Magit extensions for using GitHub
;; markdown-mode     1.8.1       installed  Emacs Major mode for Markdown-formatted text files
;; multiple-cursors  1.1.3       installed  Multiple cursors for Emacs.
;; nrepl             0.1.6       installed  Client for Clojure nREPL
;; paredit           22          installed  Minor mode for editing parentheses  -*- Mode: Emacs-Lisp -*-
;; rvm               1.2         installed  Emacs integration for rvm
;; sass-mode         3.0.14      installed  Major mode for editing Sass files
;; scss-mode         0.5.0       installed  Major mode for editing SCSS files
;; slime             20100404.1  installed  Superior Lisp Interaction Mode for Emacs
;; slime-repl        20100404    installed  Read-Eval-Print Loop written in Emacs Lisp
;; yaml-mode         0.0.7       installed  Major mode for editing YAML files
