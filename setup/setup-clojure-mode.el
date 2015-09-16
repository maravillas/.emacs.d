(require 'clojure-mode)

;;(define-key clojure-mode-map (kbd "C-c C-j") 'clj-jump-to-other-file)
;;(define-key clojure-mode-map (kbd "C-c M-j") 'clj-jump-to-other-file-other-window)

(defadvice clojure-test-run-tests (before save-first activate)
  (save-buffer))

(defadvice nrepl-load-current-buffer (before save-first activate)
  (save-buffer))

;; (eval-after-load "nrepl"
;;   '(progn
;;      (define-key nrepl-mode-map (kbd "C-,") 'complete-symbol)
;;      (define-key nrepl-interaction-mode-map (kbd "C-,") 'complete-symbol)))

;; lazy-test indention

(eval-after-load 'clojure-mode
  '(define-clojure-indent
     (describe 'defun)
     (testing 'defun)
     (given 'defun)
     (using 'defun)
     (with 'defun)
     (it 'defun)
     (do-it 'defun)))

(require 'clj-refactor)

(add-hook 'clojure-mode-hook
          (lambda ()
            (clj-refactor-mode 1)
            (cljr-add-keybindings-with-prefix "M-r")
            (define-key clj-refactor-map (kbd "C-x C-r") 'cljr-rename-file-or-dir)))


(provide 'setup-clojure-mode)
