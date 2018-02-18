# git-extend(1)

`git-extend` is a lightweight wrapper for Git builtins.

## Table of Contents

- [Description](#description)
- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
- [Options](#options)
- [Templates](#templates)

## Description

`git-extend` provides the ability to extend Git builtins via command wrappers. It is intended for the individual who wants to use Git builtins organically, with a hint of customization.

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

+ `--bypass`: Bypass all `git-extend` command wrappers.

## Templates

Templates are provided for several porcelain commands, including:

+ `git-add`
+ `git-branch`
+ `git-log`
+ `git-reflog`

See [TEMPLATES.md](https://github.com/nickolasburr/git-extend/blob/master/TEMPLATES.md) for a list of available templates and explanations of what each template offers.
