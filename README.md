# git-wrap(1)

`git-wrap` is an executable wrapper for Git.

## Table of Contents

- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
- [Options](#options)
- [Templates](#templates)

## Installation

You can install `git-wrap` via Homebrew or manually.

### Homebrew

```
brew tap nickolasburr/pfa
brew install git-wrap
```

### Manual

```
git clone https://github.com/nickolasburr/git-wrap.git
make
make install
```

## Options

+ `--bypass`, `-b`: Bypass all `git-wrap` command wrappers.

## Templates

Templates are provided for several porcelain commands:

+ `git-add`
+ `git-branch`
+ `git-log`
+ `git-reflog`
