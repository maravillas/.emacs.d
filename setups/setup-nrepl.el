(require 'nrepl)

(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)

(provide 'setup-nrepl)
