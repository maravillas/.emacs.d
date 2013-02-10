;; My keybindings for paredit

(require 'paredit)

;; (autoload 'paredit-mode "paredit" t)

(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

(defun setup-paredit-for-mode-map (mode-map)
  (define-key mode-map (kbd ";")   'nil)
  
  (define-key mode-map (kbd ")")   'paredit-close-parenthesis)
  (define-key mode-map (kbd "M-)") 'paredit-close-parenthesis-and-newline)
  
  (define-key mode-map (kbd "{")   'paredit-open-curly)
  (define-key mode-map (kbd "}")   'paredit-close-curly)

  (define-key mode-map (kbd "<M-left>") 'paredit-backward-barf-sexp)
  (define-key mode-map (kbd "<M-right>") 'paredit-forward-slurp-sexp)

  (define-key mode-map (kbd "<C-left>") 'backward-word)
  (define-key mode-map (kbd "<C-right>") 'forward-word)

  (define-key mode-map (kbd "DEL") 'paredit-backward-delete))

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

(eval-after-load "lisp-mode" '(setup-paredit-for-mode-map emacs-lisp-mode-map))
(eval-after-load "clojure-mode" '(setup-paredit-for-mode-map clojure-mode-map))

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

(provide 'setup-paredit)
