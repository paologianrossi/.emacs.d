;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files

(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(setq build-dir (expand-file-name "build/" dotfiles-dir))

(let* ((org-dir (expand-file-name
                 "lisp" (expand-file-name
                         "org" (expand-file-name
                                "src" dotfiles-dir))))
       (org-contrib-dir (expand-file-name
                         "lisp" (expand-file-name
                                 "contrib" (expand-file-name
                                            ".." org-dir))))
       (load-path (append (list org-dir org-contrib-dir)
                          (or load-path nil))))
  ;; load up Org-mode and Org-babel
  (require 'org-install)
  (require 'ob-tangle))

(defun paolog-load-init-file (path file)
  "Load Emacs Lisp source code blocks in the Org-mode FILE.
This function exports the source code using
`org-babel-tangle' and then loads the resulting file using
`load-file'."
  (let* ((age (lambda (file)
		(float-time
		 (time-subtract (current-time)
				(nth 5 (or (file-attributes (file-truename file))
					   (file-attributes file)))))))
	 (base-name (file-name-base file))
	 (exported-file (expand-file-name (concat base-name ".el") path)))
    ;; tangle if the org-mode file is newer than the elisp file
    (unless (and (file-exists-p exported-file)
		 (> (funcall age file) (funcall age exported-file)))
      (org-babel-tangle-file file exported-file "emacs-lisp"))
    (load-file exported-file)
    (message "Loaded %s" exported-file)))

;; load up all literate org-mode files in this directory
(mapc (apply-partially 'paolog-load-init-file build-dir) (directory-files dotfiles-dir t "\\.org$"))

;;; init.el ends here
