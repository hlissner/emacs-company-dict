[![MIT](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![MELPA](http://melpa.org/packages/company-dict-badge.svg)](http://melpa.org/#/company-dict)
[![MELPA Stable](http://stable.melpa.org/packages/company-dict-badge.svg)](http://stable.melpa.org/#/company-dict)

# Company Dictionary

This simple [company] backend emulates `ac-source-dictionary` and vim's
dictionary omnicompletion (`C-x C-k`). It's much like `company-keywords`, but
with lazy-loaded dictionary files, and support for annotations and
documentation.

+ It is meant as an alternative to `company-keywords`.
+ A dictionary is a plaintext file named after the major-mode in which it should
  be active.
+ The dictionary file `all` applies to all modes.
+ This file is a newline-delimited list of keywords.
+ Each keyword is tab-delimited in the following format: `[keyword]
  [[annotation] [documentation]]`
  + e.g. `os.path.basename [function] Return the base name of pathname path`
  + ![Screenshot](../screenshots/delimited.png)
  + **NOTE:** the parser squashes multiple tab characters, so use as many tabs
    as you'd like to organize your dictionary files.

## Installation

`M-x package-install RET company-dict`

## Usage

```elisp
(require 'company-dict)

;; Where to look for dictionary files. Default is ~/.emacs.d/dict
(setq company-dict-dir (concat user-emacs-directory "dict/"))

;; Optional: if you want it available everywhere
(add-to-list 'company-backends 'company-dict)

;; Optional: evil-mode users may prefer binding this to C-x C-k for vim
;; omni-completion-like dictionary completion
(define-key evil-insert-state-map (kbd "C-x C-k") 'company-dict)
```

Add minor mode symbols to `company-dict-minor-mode-list` to make company-dict
aware of minor mode dictionaries.

### Yasnippet integration

`company-dict` autocompletions are automatically expanded like they're
[yasnippet] snippets **if yasnippet is installed and `yas-minor-mode` is
enabled in the current buffer**.

Yasnippet is not a dependency of company-dict, so you must install and enable it
yourself. Which can be done through MELPA: `M-x package-install RET yasnippet`

To disable this behavior, set `company-dict-enable-yasnippet` to `nil`

## Configuration

+ `company-dict-minor-mode-alist`
+ `company-dict-dir`
+ `company-dict-minor-mode-alist`
+ `company-dict-enable-fuzzy`
+ `company-dict-enable-yasnippet`


[company]: https://github.com/company-mode/company-mode
[yasnippet]: https://github.com/joaotavora/yasnippet
