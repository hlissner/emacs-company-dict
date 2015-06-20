;;; company-dict.el --- A company backend that simulates ac-source-dictionary
;;
;; Copyright (C) 2015 Henrik Lissner

;; Author: Henrik Lissner <http://github/hlissner>
;; Maintainer: Henrik Lissner <henrik@lissner.net>
;; Created: June 21, 2015
;; Modified: June 21, 2015
;; Version: 1.0.0
;; Keywords: company dictionary ac-source-dictionary
;; Homepage: https://github.com/hlissner/company-dict
;; Package-Requires: ((company "0.9.0") (dash "2.10.0"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Code:

(require 'company)
(require 'dash)

(defcustom company-dict-dir (concat user-emacs-directory "dict/")
  "Directory to look for dictionary files."
  :group 'company)

(defcustom company-dict-minor-mode-alist '()
  "A list of minor modes to look up dictionaries for (if they're active)."
  :group 'company)

(defvar company-dict--alist '())

(defun company-dict--read-file (file-path)
  (decode-coding-string
   (with-temp-buffer
     (set-buffer-multibyte nil)
     (setq buffer-file-coding-system 'binary)
     (insert-file-contents-literally path)
     (buffer-substring-no-properties (point-min) (point-max))) 'utf-8))

(defun company-dict-get-relevant-dicts ()
  (let ((minor-modes (-filter (lambda (mode) (when (boundp mode) (symbol-value mode)))
                              company-dict-minor-mode-alist))
        (dicts (cdr (assq major-mode company-dict--alist))))
    (dolist (mode minor-modes)
      (setq dicts (append dicts (cdr (assq mode company-dict--alist)))))
    dicts))

(defun company-dict-init ()
  "Read dict files and populate dictionary."
  (dolist (file (directory-files company-dict-dir t "^[^.]"))
    (add-to-list 'company-dict--alist `(,(intern (file-name-nondirectory (directory-file-name file)))
                                        ,@(split-string (company-dict--read-file file) "\n" nil)))))

;;;###autoload
(defun company-dict (command &optional arg &rest ignored)
  "`company-mode' backend for user-provided dictionaries."
  (interactive (list 'interactive))
  (unless company-dict--alist
    (company-dict-init))
  (let ((dict (company-dict-get-relevant-dicts)))
    (cl-case command
      (interactive (company-begin-backend 'company-dict))
      (prefix (and dict (or (company-grab-symbol) 'stop)))
      (candidates (let ((completion-ignore-case nil)
                        (symbols dict))
                    (all-completions arg symbols)))
      (sorted t))))

(provide 'company-dict)
;;; company-dict.el ends here
