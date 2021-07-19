(require 'erlang-start)

(message "Setting up erlang-mode...")

(defun find-rebar-root ()
  (let ((dir (locate-dominating-file default-directory "rebar.config")))
    (or dir default-directory)))

(defun inferior-erlang-compile-rebar ()
  (interactive)
  (let ((default-directory (find-rebar-root)))
    (compile "make")))

(defun rebar-erlang-mode-hook ()
  (local-set-key (kbd "C-c C-k") 'inferior-erlang-compile-rebar))

(add-hook 'erlang-mode-hook 'rebar-erlang-mode-hook)

(defun my/disable-paredit-spaces-before-paren ()
  ;; Function which always returns nil -> never insert a space when insert a parentheses.
  (defun my/erlang-paredit-space-for-delimiter-p (endp delimiter) nil)
  ;; Set this function locally as only predicate to check when determining if a space should be inserted
  ;; before a newly created pair of parentheses.
  (setq-local paredit-space-for-delimiter-predicates '(my/erlang-paredit-space-for-delimiter-p)))

(add-hook 'erlang-mode-hook 'my/disable-paredit-spaces-before-paren)

(provide 'setup-erlang-mode)