;; I forget why, but I think 6.5.5 (in marmalade) didn't work

(require 'color-theme)

(eval-after-load "color-theme"
  '(progn
     (require 'color-theme-maravillas)
     (color-theme-maravillas)))

(provide 'setup-color-theme)
