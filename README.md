# Company Dictionary

A simple backend for [company-mode](https://github.com/company-mode/company-mode) that
emulates `ac-source-dictionary` and vim's dictionary omnicompletion (`C-x C-k`). It's much
like `company-keywords`, but with lazy-loaded dictionary files.

+ It is not meant to replace `company-keywords`.
+ A dictionary is a plaintext file named after the major-mode in which it should be active.
  This file is a newline-delimited list of keywords.
+ The dictionary file `all` applies to all modes.
+ Each line is tab-delimited and comprised of three fields (one required, the
  rest optional): the candidate, an annotation and its documentation. e.g.

  `os.path.basename	[function]	Return a normalized absolutized version of the pathname path`

  ![Screenshot](../screenshots/delimited.png)

  **NOTE:** the parser squashes multiple tab characters, so use as many tabs as you'd
  like to organize your dictionary files.

## Installation

`M-x package-install RET company-dict`

## Usage

```elisp
(require 'company-dict)

;; Where to look for dictionary files. Default is ~/.emacs.d/dict
(setq company-dict-dir (concat user-emacs-directory "dict/"))

;; Optional: if you want it available everywhere
(add-to-list 'company-backends 'company-dict)

;; Optional: evil-mode users may prefer binding this to C-x C-k for vim-like
dictionary completion
(define-key evil-insert-state-map (kbd "C-x C-k") 'company-dict)
```

Add minor mode symbols to `company-dict-minor-mode-list` if you'd like
company-dict to be aware of minor mode dictionaries.

## TODO

+ Add yasnippet support
