;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(define-key global-map "\C-cc" 'org-capture)

;; windows
(global-set-key [C-M-down]  'win-resize-minimize-vert)
(global-set-key [C-M-up]    'win-resize-enlarge-vert)
(global-set-key [C-M-left]  'win-resize-minimize-horiz)
(global-set-key [C-M-right] 'win-resize-enlarge-horiz)
(global-set-key [C-M-up]    'win-resize-enlarge-horiz)
(global-set-key [C-M-down]  'win-resize-minimize-horiz)
(global-set-key [C-M-left]  'win-resize-enlarge-vert)
(global-set-key [C-M-right] 'win-resize-minimize-vert)

;; ibuffer

(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key [C-x k] 'kill-this-buffer)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-x r") 'rgrep)
(global-set-key (kbd "C-c C-e") 'slime-eval-defun)
(global-set-key [f11] 'revert-buffer)

;; buffer-move

(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; multiple-cursors

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->")     'mc/mark-next-like-this)
(global-set-key (kbd "C-<")     'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; ace-jump-mode

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; Definition jumping

(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; Smart M-x

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Expand region (increases selected region by semantic units)

(global-set-key (if is-mac (kbd "C-@") (kbd "C-'")) 'er/expand-region)

;; Align code with regexps

(global-set-key (kbd "C-x \\") 'align-regexp)

;; hippie-expand completion

(global-set-key (kbd "M-/") 'hippie-expand)

;; Font size

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; File finding

(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-x C-p") 'find-file-at-point)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)

;; Indentation help

(global-set-key (kbd "C-x ^") 'join-line)

;; Start eshell or switch to it if it's active.

(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.

(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Activate occur easily inside isearch

(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

(provide 'key-bindings)
