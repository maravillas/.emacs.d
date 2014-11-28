(defun skip-to-next-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-forward " >")
    (unless (search-forward-regexp "^\\s *$" nil t)
      (goto-char (point-max)))))

(defun skip-to-previous-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-backward " >")
    (unless (search-backward-regexp "^\\s *$" nil t)
      (goto-char (point-min)))))

(defun html-wrap-in-tag (beg end)
  (interactive "r")
  (let ((oneline? (= (line-number-at-pos beg) (line-number-at-pos end))))
    (deactivate-mark)
    (goto-char end)
    (unless oneline? (newline-and-indent))
    (insert "</div>")
    (goto-char beg)
    (insert "<div>")
    (unless oneline? (newline-and-indent))
    (indent-region beg (+ end 11))
    (goto-char (+ beg 4))))

(eval-after-load "sgml-mode"
  '(progn
     (define-key html-mode-map (kbd "C-<down>") 'skip-to-next-blank-line)
     (define-key html-mode-map (kbd "C-<up>") 'skip-to-previous-blank-line)
     (define-key html-mode-map (kbd "C-c C-w") 'html-wrap-in-tag)

     ;; Don't show buggy matching of slashes
     (define-key html-mode-map (kbd "/") nil)

     (require 'tagedit)
     (define-key html-mode-map (kbd "M-<right>") 'tagedit-forward-slurp-tag)
     (define-key html-mode-map (kbd "M-<left>") 'tagedit-forward-barf-tag)
     (define-key html-mode-map (kbd "s-k") 'tagedit-kill-attribute)
     (define-key html-mode-map (kbd "s-<return>") 'tagedit-toggle-multiline-tag)
     ))

(provide 'setup-html-mode)
