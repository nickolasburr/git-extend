# git-extend(1)

`git-extend` is an executable wrapper for Git.

## Table of Contents

- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
- [Options](#options)
- [Templates](#templates)

## Installation

You can install `git-extend` via Homebrew or manually.

### Homebrew

```
brew tap nickolasburr/pfa
brew install git-extend
```

### Manual

```
git clone https://github.com/nickolasburr/git-extend.git
make
make install
```

## Options

+ `--bypass`, `-b`: Bypass all `git-extend` command wrappers.

## Templates

Templates are provided for several porcelain commands:

+ `git-add`
+ `git-branch`
+ `git-log`
+ `git-reflog`
