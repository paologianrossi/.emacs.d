;;; init.el --- Where all the magic begins
;;
;;; Commentary:
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs Lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files

;;; Code:

(defconst dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name))
  "The root directory of init files.")

(defconst build-dir (expand-file-name "build/" dotfiles-dir)
  "Where .el files are built and cached.")

(defconst var-dir (expand-file-name "var" dotfiles-dir)
  "Where files managed by Emacs and not supposed to be edited directly are kept.")

(defconst elisp-dir (expand-file-name "src" dotfiles-dir)
  "Where elisp extensions are kept.")

(defconst vendor-dir (expand-file-name "vendor" dotfiles-dir)
  "Where non-elisp extensions are kept.")

(defconst private-dir (expand-file-name "private" dotfiles-dir)
  "This module is untracked by git.  Put private information there."
  )

(require 'package)
(package-initialize)

(require 'org)

(defun directory-files-recursive (directory &optional match ignore maxdepth)
  "List files in DIRECTORY and in its sub-directories.
Return files that match the regular expression MATCH but ignore
files and directories that match IGNORE (IGNORE is tested before
MATCH.  Recurse only to depth MAXDEPTH.  If zero or negative, then
do not recurse.

Blatant copy-paste from here (with some adaptation):
http://turingmachine.org/bl/2013-05-29-recursively-listing-directories-in-elisp.html"
  (let* ((files-list '())
         (current-directory-list
          (directory-files directory t))
         (maxdepth (or maxdepth 100))
         )
    ;; while we are in the current directory
     (while current-directory-list
       (let ((f (car current-directory-list)))
         (cond
          ((and
           ignore ;; make sure it is not nil
           (string-match ignore f))
           ; ignore
            nil
           )
          ((or (not match) (and
            (file-regular-p f)
            (file-readable-p f)
            (string-match match f)))
          (setq files-list (cons f files-list)))
          ((and
           (file-directory-p f)
           (file-readable-p f)
           (not (string-equal ".." (substring f -2)))
           (not (string-equal "." (substring f -1)))
           (> maxdepth 0))
           ;; recurse only if necessary
           (setq files-list (append files-list (directory-files-recursive f match ignore (- maxdepth -1))))
           (setq files-list (cons f files-list))
           )
          (t)
          )
         )
       (setq current-directory-list (cdr current-directory-list))
       )
       files-list
     )
  )

(defun load-org-init-file (path file)
  "Load Emacs Lisp source code blocks from passed `org-mode' FILE.

This function exports the source code using `org-babel-tangle' to
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

(defalias 'load-org-init-filename (apply-partially 'load-org-init-file build-dir)
  "Load Emacs Lisp source code blocks in the Org-mode FILE. Store cache .el files in `build-dir`")

(defun load-init-file (file)
  "Load smartly the init file FILE.

   FILE can be:

  - an Org-mode file path (extension: .org).  In this case, load
    Emacs Lisp source code blocks in FILE.  Store cache .el files
    in `build-dir`;
  - an Emacs-lisp file path (extension: .el).  In this case, just
    load FILE;

  - an extensionless file name.  In this case, append '.org' to FILE
    name and load as Org-mode file.

FILE can be an absolute or relative path to a file.
In case of a relative path, it is rooted on `dotfiles-dir`."
  (interactive "fFile:")
  (unless (or (equal "org" (file-name-extension file)) (equal "el" (file-name-extension file)))
    (setq file (concat file ".org")))
  (setq file (expand-file-name file dotfiles-dir))
  (if (equal "org" (file-name-extension file))
      (load-org-init-filename file)
    (load file)))

(load-init-file "emacs.org")
(put 'upcase-region 'disabled nil)

(provide 'init)
;;; init.el ends here
