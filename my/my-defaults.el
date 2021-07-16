;; Default the font size to 11pt

(set-face-attribute 'default nil :height 110)

;; Save point position between sessions

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Allow pasting selection outside of Emacs

(setq x-select-enable-clipboard t)

;; Auto refresh buffers

(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it

(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Show keystrokes in progress

(setq echo-keystrokes 0.1)

;; Move files to trash when deleting

(setq delete-by-moving-to-trash t)

;; Real emacs knights don't use shift to mark things

(setq shift-select-mode nil)

;; Transparently open compressed files

(auto-compression-mode t)

;; Answering just 'y' or 'n' will do

(defalias 'yes-or-no-p 'y-or-n-p)

(setq visible-bell t)

;; UTF-8 please

(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Show active region

(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Remove text in active region if inserting text

(delete-selection-mode 1)

;; Don't highlight matches with jump-char - it's distracting

(setq jump-char-lazy-highlight-face nil)

;; Always display line and column numbers

(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72

(setq fill-column 80)

;; Undo/redo window configuration with C-c <left>/<right>

(winner-mode 1)

;; Never insert tabs

(set-default 'indent-tabs-mode nil)

;; Show me empty lines after buffer end

(set-default 'indicate-empty-lines t)

;; Easily navigate sillycased words

(global-subword-mode 1)

;; One line at a time

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) 

;; Don't accelerate scrolling

(setq mouse-wheel-progressive-speed nil)

;; Scroll window under mouse

(setq mouse-wheel-follow-mouse 't)

;; Keyboard scroll one line at a time

(setq scroll-step 1)

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)

(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks

(setq org-src-fontify-natively t)

;; Sentences do not need double spaces to end. Period.

(set-default 'sentence-end-double-space nil)

;; A saner ediff

(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; that you can always see what's happening.

(setq eval-expression-print-level nil)

;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.

(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

;; Disable some beeps

(defun my-bell-function ()
  (unless (memq this-command
                '(isearch-abort
                  abort-recursive-edit
                  exit-minibuffer
                  keyboard-quit
                  mwheel-scroll
                  down up
                  next-line previous-line
                  backward-char forward-char))
    (ding)))

(setq ring-bell-function 'my-bell-function)

(require 're-builder)
(setq reb-re-syntax 'string)

(provide 'my-defaults)
