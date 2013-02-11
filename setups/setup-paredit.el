;; My keybindings for paredit

(require 'paredit)

;; (autoload 'paredit-mode "paredit" t)

(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

(defun setup-paredit-mode-map ()
  (define-key paredit-mode-map (kbd ";")   'nil)
  
  (define-key paredit-mode-map (kbd ")")   'paredit-close-parenthesis)
  (define-key paredit-mode-map (kbd "M-)") 'paredit-close-parenthesis-and-newline)
  
  (define-key paredit-mode-map (kbd "{")   'paredit-open-curly)
  (define-key paredit-mode-map (kbd "}")   'paredit-close-curly)

  (define-key paredit-mode-map (kbd "<M-left>") 'paredit-backward-barf-sexp)
  (define-key paredit-mode-map (kbd "<M-right>") 'paredit-forward-slurp-sexp)

  (define-key paredit-mode-map (kbd "<C-left>") 'backward-word)
  (define-key paredit-mode-map (kbd "<C-right>") 'forward-word)

  (define-key paredit-mode-map (kbd "DEL") 'paredit-backward-delete)
  (define-key paredit-mode-map (kbd "<C-backspace>") 'paredit-backward-kill-word))

;; (defun setup-paredit-for-mode-map (mode-map)
;;   (define-key mode-map (kbd "s-<up>") 'paredit-raise-sexp)
;;   (define-key mode-map (kbd "s-<right>") 'paredit-forward-slurp-sexp)
;;   (define-key mode-map (kbd "s-<left>") 'paredit-forward-barf-sexp)
;;   (define-key mode-map (kbd "s-S-<left>") 'paredit-backward-slurp-sexp)
;;   (define-key mode-map (kbd "s-S-<right>") 'paredit-backward-barf-sexp)
;;   (define-key mode-map (kbd "s-8") 'paredit-wrap-round)
;;   (define-key mode-map (kbd "s-9") 'paredit-wrap-round-from-behind)
;;   (define-key mode-map (kbd "s-<backspace>") 'paredit-splice-sexp-killing-backward)
;;   (define-key mode-map (kbd "s-t") 'transpose-sexps))

;; (eval-after-load 'lisp-mode '(setup-paredit-for-mode-map emacs-lisp-mode-map))
;; (eval-after-load 'clojure-mode '(setup-paredit-for-mode-map clojure-mode-map))

(eval-after-load 'paredit '(setup-paredit-mode-map))

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

;; SLIME

(defun enable-paredit-mode ()
  (paredit-mode +1))

(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

(defun fix-paredit-repl ()
  (interactive)
  (local-set-key "{" 'paredit-open-curly)
  (local-set-key "}" 'paredit-close-curly)
  (modify-syntax-entry ?\{ "(}") 
  (modify-syntax-entry ?\} "){")
  (modify-syntax-entry ?\[ "(]")
  (modify-syntax-entry ?\] ")["))

(fix-paredit-repl)

(provide 'setup-paredit)
