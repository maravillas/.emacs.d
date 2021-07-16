(require 'cider)

(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-interaction-mode-hook 'eldoc-mode)
(add-hook 'cider-mode-hook 'eldoc-mode)
(setq nrepl-hide-special-buffers nil)
(setq cider-repl-history-file "~/.emacs.d/.cider-history")
(setq cider-auto-select-error-buffer nil)

(provide 'setup-cider)
