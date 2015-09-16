(require 'clj-refactor)

(defun clj-refactor-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'clj-refactor-clojure-mode-hook)

(provide 'setup-clj-refactor)
