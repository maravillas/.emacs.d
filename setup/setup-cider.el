(require 'cider)

(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-interaction-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers nil)
(setq cider-repl-history-file "/Users/maravillas/.emacs.d/.cider-history")
(setq cider-auto-select-error-buffer nil)

(provide 'setup-cider)
