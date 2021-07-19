(require 'tagedit)

;; TODO probably need to try this out in web-mode instead

(define-key html-mode-map (kbd "M-<right>") 'tagedit-forward-slurp-tag)
(define-key html-mode-map (kbd "M-<left>") 'tagedit-forward-barf-tag)
(define-key html-mode-map (kbd "s-k") 'tagedit-kill-attribute)
(define-key html-mode-map (kbd "s-<return>") 'tagedit-toggle-multiline-tag)

(provide 'setup-tagedit)