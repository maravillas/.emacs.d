;; change command to meta, and ignore option to use weird Norwegian keyboard

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
;;(setq mac-option-modifier nil)
(setq mac-option-modifier 'super)
(setq ns-function-modifier 'hyper)

;; mac friendly font

(set-face-attribute 'default nil :font "Monaco-11")

;; make sure path is correct when launched as application

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; keybinding to toggle full screen mode

(global-set-key (quote [M-f10]) (quote ns-toggle-fullscreen))

;; Move to trash when deleting stuff

(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

;; Ignore .DS_Store files with ido mode

(add-to-list 'ido-ignore-files "\\.DS_Store")

;; Don't open files from the workspace in a new frame

(setq ns-pop-up-frames nil)

;; Use aspell for spell checking: brew install aspell --lang=en

(setq ispell-program-name "/usr/local/bin/aspell")

;; Git executable

(setq magit-git-executable "/usr/bin/git")

;; Android SDK tools

(add-to-list 'load-path "~/android-sdks/tools/lib")

(provide 'my-mac)
