(require 'org-install)

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

(setq org-agenda-files (list "~/org/todo.org"))
(setq org-startup-indented t)

(defun myorg-update-parent-cookie ()
  (when (equal major-mode 'org-mode)
    (save-excursion
      (org-back-to-heading)
      (org-update-parent-todo-statistics))))

(defadvice org-kill-line (after fix-cookies activate)
  (myorg-update-parent-cookie))

(defadvice kill-whole-line (after fix-cookies activate)
  (myorg-update-parent-cookie))

(provide 'setup-org)
