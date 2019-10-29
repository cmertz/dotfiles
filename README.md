# dotfiles

This is a plain git repository with the dotfiles that are common to all
of my workstations. They are simply cloned to `/`.

The `.gitignore` excludes everything by default, things have to be added
explicitly via `git add -f ...`.

Deriving or additional dotfiles are cloned on top of
this (to `/` as well). Use `GIT_DIR` or `git --git-dir` to work with this.
