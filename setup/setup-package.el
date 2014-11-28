;; Init package manager and set up ELPA repository
(require 'package)

(setq package-archives
      '(;("marmalade" . "http://marmalade-repo.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(unless (and ;(file-exists-p "~/.emacs.d/elpa/archives/marmalade")
             (file-exists-p "~/.emacs.d/elpa/archives/gnu")
             (file-exists-p "~/.emacs.d/elpa/archives/melpa"))
  (package-refresh-contents))

;; (defun packages-install (&rest packages)
;;   (mapc (lambda (package)
;;           (let ((name (car package))
;;                 (repo (cdr package)))
;;             (when (not (package-installed-p name))
;;               (let ((package-archives (list repo)))
;;                 (package-initialize)
;;                 (package-install name)))))
;;         packages)
;;   (package-initialize)
;;   (delete-other-windows))

;; (defun ensure-package-installed (package &optional repository)

(defun ensure-package-installed (package)
  (unless (package-installed-p package)
    (package-install package)))

(defun sacha/package-install (package &optional repository)
  "Install PACKAGE if it has not yet been installed.
If REPOSITORY is specified, use that."
  (unless (package-installed-p package)
    (let ((package-archives (if repository
                                (list (assoc repository package-archives))
                              package-archives)))
      (package-install package))))

(provide 'setup-package)
