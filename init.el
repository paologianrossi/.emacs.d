;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files

(defconst dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name))
  "The root directory of init files")

(defconst build-dir (expand-file-name "build/" dotfiles-dir)
  "Where .el files are built and cached.")

;; select a local version of Org-mode if present
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
  "Load Emacs Lisp source code blocks in the Org-mode FILE.  This
function exports the source code using `org-babel-tangle' to
PATH directory and then loads the resulting file using
`load-file'.  Creates PATH if it doesn't exist."
  (let* ((age (lambda (file)
		(float-time
		 (time-subtract (current-time)
				(nth 5 (or (file-attributes (file-truename file))
					   (file-attributes file)))))))
	 (base-name (file-name-base file))
	 (exported-file (expand-file-name (concat base-name ".el") path)))
    (make-directory path t)
    ;; tangle if the org-mode file is newer than the elisp file
    (unless (and (file-exists-p exported-file)
		 (> (funcall age file) (funcall age exported-file)))
      (org-babel-tangle-file file exported-file "emacs-lisp"))
    (load-file exported-file)
    (message "Loaded %s (%s)" file exported-file)))

(defalias 'load-init-filename (apply-partially 'paolog-load-init-file build-dir)
  "Load Emacs Lisp source code blocks in the Org-mode FILE. Store cache .el files in `build-dir`")

(defun load-init-file (file)
  "Load smartly the init file FILE.

FILE can be:
  - an Org-mode file path (extension: .org).  In this case, load Emacs Lisp source code blocks in FILE. Store cache .el files in `build-dir`;
  - an Emacs-lisp file path (extension: .el). In this case, just load FILE;
  - an extensionless file name. In this case, append '.org' to FILE name and load as Org-mode file.

FILE can be an absolute or relative path to a file.  In case of a relative path, it is rooted on `dotfiles-dir`.
"
  (interactive "fFile:")
  (unless (or (equal "org" (file-name-extension file)) (equal "el" (file-name-extension file)))
    (setq file (concat file ".org")))
  (setq file (expand-file-name file dotfiles-dir))
  (if (equal "org" (file-name-extension file))
      (load-init-filename file)
    (load file)))

(load-init-file "emacs.org")
