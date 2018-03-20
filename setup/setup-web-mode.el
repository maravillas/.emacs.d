
;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(add-hook 'web-mode-hook  'my-web-mode-hook)


;; (setq web-mode-content-types-alist
;;       '(("jsx"  . ".*\\.js[x]?\\'")))
;; (set-face-attribute 'web-mode-doctype-face nil :foreground "blue4")
;; (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "purple4")
;; (set-face-attribute 'web-mode-html-attr-value-face nil :foreground "red4")
;; (set-face-attribute 'web-mode-html-tag-face nil :foreground "blue4")

;; (defadvice web-mode-highlight-part (around tweak-jsx activate)
;;   (if (equal web-mode-content-type "jsx")
;;       (let ((web-mode-enable-part-face nil))
;;         ad-do-it)
;;     ad-do-it))


;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (equal web-mode-content-type "jsx")
;;               ;; enable flycheck
;;               (flycheck-select-checker 'javascript-eslint)
;;               (flycheck-mode))
;;             (when (equal web-mode-content-type "js")
;;               ;; enable flycheck
;;               (flycheck-select-checker 'javascript-eslint)
;;               (flycheck-mode))
;;             ))

(provide 'setup-web-mode)
