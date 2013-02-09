
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

(set-face-attribute 'default nil :height 110)

(setq frame-title-format '("" "%b - Emacs " emacs-version))

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

(add-to-list 'load-path "~/.emacs.d")

(tool-bar-mode 0)

;; Marmalade

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Bleeding edge (git head for nrepl, and others?)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; magit

(setq magit-git-executable "/usr/bin/git")
(global-set-key (kbd "C-x g") 'magit-status)

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
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
(setq org-agenda-files (list "~/org/todo.org"))

(define-key global-map "\C-cc" 'org-capture)

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

;; windows

(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the middle"
  (let* ((win-edges (window-edges))
	 (this-window-y-min (nth 1 win-edges))
	 (this-window-y-max (nth 3 win-edges))
	 (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the middle"
  (let* ((win-edges (window-edges))
	 (this-window-x-min (nth 0 win-edges))
	 (this-window-x-max (nth 2 win-edges))
	 (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

(global-set-key [C-M-down] 'win-resize-minimize-vert)
(global-set-key [C-M-up] 'win-resize-enlarge-vert)
(global-set-key [C-M-left] 'win-resize-minimize-horiz)
(global-set-key [C-M-right] 'win-resize-enlarge-horiz)
(global-set-key [C-M-up] 'win-resize-enlarge-horiz)
(global-set-key [C-M-down] 'win-resize-minimize-horiz)
(global-set-key [C-M-left] 'win-resize-enlarge-vert)
(global-set-key [C-M-right] 'win-resize-minimize-vert)


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

(global-set-key (kbd "C-x C-b") 'ibuffer)
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

(global-set-key [C-x k] 'kill-this-buffer)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-x r") 'rgrep)
(global-set-key (kbd "C-c C-e") 'slime-eval-defun)
(global-set-key [f11] 'revert-buffer)

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

(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; multiple-cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; nrepl
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)

(require 'cljsbuild-mode)

;; Keybinds from emacs-starter-kit
;; http://eschulte.me/emacs-starter-kit/starter-kit-bindings.html

;;Align your code in a pretty way.

(global-set-key (kbd "C-x \\") 'align-regexp)

;; Completion that uses many different methods to find options.

(global-set-key (kbd "M-/") 'hippie-expand)

;; Font size

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Jump to a definition in the current file. (This is awesome.)

;; https://gist.github.com/magnars/2360578
(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
 
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
 
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
 
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; File finding

(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-x C-p") 'find-file-at-point)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)

;; Indentation help

(global-set-key (kbd "C-x ^") 'join-line)

;; Start eshell or switch to it if it's active.

(global-set-key (kbd "C-x m") 'eshell)

;;Start a new eshell even if one is active.

(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Activate occur easily inside isearch

(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))
