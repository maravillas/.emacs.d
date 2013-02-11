
(setq font-lock-verbose nil)

;; Indentation

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2)))

;; Backup file naming

(defun make-backup-file-name (FILE)                                             
  (let ((dirname (concat "~/.backups/emacs/"                                    
                         (format-time-string "%y/%m/%d/"))))                    
    (if (not (file-exists-p dirname))                                           
        (make-directory dirname t))                                             
    (concat dirname (file-name-nondirectory FILE))))

(provide 'misc)
