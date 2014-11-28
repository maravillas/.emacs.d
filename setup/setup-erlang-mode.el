(require 'erlang-start)

(message "Setting up erlang-mode...")

(defun find-rebar-root ()
  (let ((dir (locate-dominating-file default-directory "rebar.config")))
    (or dir default-directory)))

(defun inferior-erlang-compile-rebar ()
  (interactive)
  (let ((default-directory (find-rebar-root)))
    (compile "make")))

(defun rebar-erlang-mode-hook ()
  (local-set-key (kbd "C-c C-k") 'inferior-erlang-compile-rebar))

(add-hook 'erlang-mode-hook 'rebar-erlang-mode-hook)

(provide 'setup-erlang-mode)




;; (defun inferior-erlang ()
;;   "Run an inferior Erlang.

;; This is just like running Erlang in a normal shell, except that
;; an Emacs buffer is used for input and output.

;; The command line history can be accessed with  M-p  and  M-n.
;; The history is saved between sessions.

;; Entry to this mode calls the functions in the variables
;; `comint-mode-hook' and `erlang-shell-mode-hook' with no arguments.

;; The following commands imitate the usual Unix interrupt and
;; editing control characters:
;; \\{erlang-shell-mode-map}"
;;   (interactive)
;;   (require 'comint)
;;   (let ((opts inferior-erlang-machine-options))
;;     (cond ((eq inferior-erlang-shell-type 'oldshell)
;; 	   (setq opts (cons "-oldshell" opts)))
;; 	  ((eq inferior-erlang-shell-type 'newshell)
;; 	   (setq opts (append '("-newshell" "-env" "TERM" "vt100") opts))))
;;     (setq inferior-erlang-buffer
;; 	  (apply 'make-comint
;; 		 inferior-erlang-process-name inferior-erlang-machine
;; 		 nil opts)))
;;   (setq inferior-erlang-process
;; 	(get-buffer-process inferior-erlang-buffer))
;;   (process-kill-without-query inferior-erlang-process)
;;   (switch-to-buffer inferior-erlang-buffer)
;;   (if (and (not (eq system-type 'windows-nt))
;; 	   (eq inferior-erlang-shell-type 'newshell))
;;       (setq comint-process-echoes t))
;;   ;; `rename-buffer' takes only one argument in Emacs 18.
;;   (condition-case nil
;;       (rename-buffer inferior-erlang-buffer-name t)
;;     (error (rename-buffer inferior-erlang-buffer-name)))
;;   (erlang-shell-mode))
