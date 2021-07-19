(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("js" (mode . javascript-mode))
               ("ejs" (name . "\.ejs$"))
               ("erl" (mode . erlang-mode))
               ("ex" (mode . elixir-mode))
               ("magit proc" (name . "^\\magit-"))
               ("magit" (name . "^\\magit:"))
               ("ag" (name . "^\\*ag search"))
               ("nrepl" (or
                         (name . "^\\*nrepl")
                         (name . "^\\*cider")))
               ("emacs" (name . "^\\*.*\\*$"))
               ("scratch" (name . "^\\*scratch"))
               ("clj" (or
                       (name . "\.clj$")
                       (name . "\.clj<[^>]+>$")))
               ("cljs" (or
                        (name . "\.cljs$")
                        (name . "\.cljs<[^>]+>$")))
               ("cljc" (or
                       (name . "\.cljc$")
                       (name . "\.cljc<[^>]+>$")))
               ("css" (name . "\.css$"))
               ("dir" (mode . dired-mode))
               ("org" (mode . org-mode))
               ("xml" (mode . nxml-mode))
               ("java" (mode . java-mode))
               ("ruby" (mode . ruby-mode))
               ("cs" (mode . csharp-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; (define-ibuffer-sorter filename-or-dired
;;   "Sort the buffers by their pathname."
;;   (:description "filenames plus dired")
;;   (string-lessp 
;;    (with-current-buffer (car a)
;;      (or buffer-file-name
;;          (if (eq major-mode 'dired-mode)
;;              (expand-file-name dired-directory))
;;          ;; so that all non pathnames are at the end
;;          "~"))
;;    (with-current-buffer (car b)
;;      (or buffer-file-name
;;          (if (eq major-mode 'dired-mode)
;;              (expand-file-name dired-directory))
;;          ;; so that all non pathnames are at the end
;;          "~"))))

;; (define-key ibuffer-mode-map (kbd "s p")     'ibuffer-do-sort-by-filename-or-dired)

(setq ibuffer-formats
      '((mark modified read-only " "
              (name 40 40 :left :elide) " "
              (size 9 -1 :right) " "
              (mode 16 16 :left :elide) " " filename-and-process)
        (mark " " (name 16 -1) " " filename)))

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(provide 'setup-ibuffer)
