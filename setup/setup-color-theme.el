;; I forget why, but I think 6.5.5 (in marmalade) didn't work

(require 'color-theme)

(defun color-theme-maravillas ()
  (interactive)
  (color-theme-install
   '(color-theme-maravillas
      ((background-color . "#060606")
       (background-mode . light)
       (border-color . "#060606")
       (cursor-color . "#a1a1a1")
       (foreground-color . "#d1d1d1")
       (mouse-color . "black"))
      (fringe ((t (:background "#1c1c1c"))))
      (mode-line ((t (:foreground "#eeeeec" :background "#360000"))))
      (region ((t (:background "#363636"))))
      (font-lock-builtin-face ((t (:foreground "#3f74ab"))))
      (font-lock-comment-face ((t (:foreground "#6e6e6e"))))
      (font-lock-function-name-face ((t (:foreground "#458e2e"))))
      (font-lock-keyword-face ((t (:foreground "#0090b8"))))
      (font-lock-string-face ((t (:foreground "#7a0008"))))
      (font-lock-type-face ((t (:foreground"#4b59d2"))))
      (font-lock-variable-name-face ((t (:foreground "#eeeeec"))))
      (minibuffer-prompt ((t (:foreground "#2273c9" :bold t))))
      (font-lock-warning-face ((t (:foreground "Red" :bold t))))
      )))

(eval-after-load "color-theme"
  '(progn
     (color-theme-maravillas)))

(provide 'setup-color-theme)
