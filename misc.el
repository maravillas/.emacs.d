
;; Indentation

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2)))

(setq font-lock-verbose nil)

(provide 'misc)
