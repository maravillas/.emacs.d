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

;; Cycle between () {} []

(defun live-delete-and-extract-sexp ()
  "Delete the sexp and return it."
  (interactive)
  (let* ((begin (point)))
    (forward-sexp)
    (let* ((result (buffer-substring-no-properties begin (point))))
      (delete-region begin (point))
      result)))

(defun live-cycle-clj-coll ()
  "convert the coll at (point) from (x) -> {x} -> [x] -> (x) recur"
  (interactive)
  (let* ((original-point (point)))
    (while (and (> (point) 1)
                (not (equal "(" (buffer-substring-no-properties (point) (+ 1 (point)))))
                (not (equal "{" (buffer-substring-no-properties (point) (+ 1 (point)))))
                (not (equal "[" (buffer-substring-no-properties (point) (+ 1 (point))))))
      (backward-char))
    (cond
     ((equal "(" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert "{" (substring (live-delete-and-extract-sexp) 1 -1) "}"))
     ((equal "{" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert "[" (substring (live-delete-and-extract-sexp) 1 -1) "]"))
     ((equal "[" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert "(" (substring (live-delete-and-extract-sexp) 1 -1) ")"))
     ((equal 1 (point))
      (message "beginning of file reached, this was probably a mistake.")))
    (goto-char original-point)))

(define-key clojure-mode-map (kbd "C-`") 'live-cycle-clj-coll)

(require 'clj-refactor)

(add-hook 'clojure-mode-hook
          (lambda ()
            (clj-refactor-mode 1)
            (cljr-add-keybindings-with-prefix "M-r")
            (define-key clj-refactor-map (kbd "C-x C-r") 'cljr-rename-file-or-dir)))

;; changed my mind, this is more annoying than it is useful
;;(add-hook 'clojure-mode-hook #'aggressive-indent-mode)

'(cljr-auto-clean-ns nil)

;; Start figwheel in cljs repl
;; https://cider.readthedocs.io/en/latest/up_and_running/#using-the-figwheel-repl-leiningen-only
(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

;; https://github.com/clojure-emacs/cider/issues/1533
(put-clojure-indent 'defui '(2 nil nil (1)))

(provide 'setup-clojure-mode)
