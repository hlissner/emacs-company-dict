# Company Dictionary

> Currently a WIP

Mimics auto-complete-mode's ac-source-dictionary source.

## Usage

Set `company-dict-dir` to the directory containing your dictionary files. By default,
this is `~/.emacs.d/dicts`.

Then add it to `company-mode`'s backends:

`(add-to-list 'company-backends 'company-dict)`
