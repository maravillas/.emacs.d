(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("js" (mode . js2-mode))
               ("ejs" (name . "\.ejs$"))
               ("magit" (name . "^\\*magit"))
               ("emacs" (name . "^\\*.*\\*$"))
               ("clj" (name . "\.clj$"))
               ("cljs" (name . "\.cljs$"))
               ("css" (name . "\.css$"))
               ("org" (mode . org-mode))
               ("xml" (mode . nxml-mode))
               ("java" (mode . java-mode))
               ("controllers" (name . "/controllers/"))
               ("models" (name . "/models/"))
               ("views" (name . "/views/"))
               ("migrations" (name . "/db/migrate/"))))))

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

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(provide 'setup-ibuffer)
