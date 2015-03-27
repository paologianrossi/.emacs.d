;;; init.el --- Where all the magic begins
;;
;;; Commentary:
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs Lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files

;;; Code:

(defconst dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name))
  "The root directory of init files")

(defconst build-dir (expand-file-name "build/" dotfiles-dir)
  "Where .el files are built and cached.")

(defconst var-dir (expand-file-name "var" dotfiles-dir)
  "Where files managed by emacs and not supposed to be edited directly are kept")

(defconst elisp-dir (expand-file-name "src" dotfiles-dir)
  "Where elisp extensions are kept")

(defconst vendor-dir (expand-file-name "vendor" dotfiles-dir)
  "Where non-elisp extensions are kept")

(defconst private-dir (expand-file-name "private" dotfiles-dir)
  "This module is untracked by git.  Put private information there"
  )

(require 'package)
(package-initialize)

;; TODO: Check for el-get

(add-to-list 'load-path "~/.emacs.d/src/org/lisp")
(add-to-list 'load-path "~/.emacs.d/src/org/contrib/lisp" t)
(require 'org)

(defun load-org-init-file (path file)
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

(defalias 'load-org-init-filename (apply-partially 'load-org-init-file build-dir)
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
      (load-org-init-filename file)
    (load file)))

(load-init-file "emacs.org")
(put 'upcase-region 'disabled nil)
