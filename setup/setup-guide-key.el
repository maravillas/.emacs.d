(require 'guide-key)

(setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
(setq guide-key/popup-window-position 'bottom)

(defun guide-key/my-hook-function-for-org-mode ()
  (guide-key/add-local-guide-key-sequence "C-c")
  (guide-key/add-local-guide-key-sequence "C-c C-x")
  (guide-key/add-local-highlight-command-regexp "org-"))
(add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)

(guide-key-mode 1) 

(provide 'setup-guide-key)
