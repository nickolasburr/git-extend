# git-extend(1)

`git-extend` is a lightweight wrapper utility for Git builtins.

## Table of Contents

- [Description](#description)
- [Purpose](#purpose)
- [Caveats](#caveats)
- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
- [Options](#options)
- [Examples](#examples)
- [Wrappers](#wrappers)

## Description

`git-extend` provides the ability to extend Git builtins via command wrappers. It is intended for the individual who wants to use Git builtins organically, with a hint of customization.

## Purpose

You may be asking yourself:

> How is this any different than using git-config aliases?

--OR--

> What advantages does git-extend provide that I can't get from git-config? Or from a shell alias?

In short, convenience and intuitiveness.

What `git-extend` provides is integration of your own options around Git builtins. Rather than having to define and remember an alias for, say, `git-log`, you customize the wrapper to your liking and add the helper options you feel benefit you the most.

## Caveats

A few important caveats to consider prior to installation:

+ When adding options to a command wrapper, make sure the builtin doesn't have an equivalent option. This will cause conflicts otherwise.
+ When in doubt, use `--bypass` to circumvent `git-extend`. See [Examples](#examples) for `--bypass` usage.
+ Always test your command wrappers somewhere safe before using them in your workflow. Bad things can happen if you're not careful.

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

## Examples

Get the name of the previous branch (assumes pre-built command wrapper for `git-branch`).

```
git branch --last
```

Excerpt from `git-branch` wrapper:

```
--last|-L)
	git check-ref-format --branch @{-1} 2>/dev/null

	if [[ $? -gt 0 ]]; then
		printf '%s\n' "$ERR_NO_PREV_BRANCH"

		exit 1
	fi

	exit 0
;;
```

Add the first pathspec in the list derived from `git-status` (assumes pre-built command wrapper for `git-add`).

```
git add %1
```

Bypass `git-extend` and get the last five log entries.

```
git --bypass log --max-count=5
```

## Wrappers

Command wrapper templates are provided for several porcelain commands, including:

+ `git-add`
+ `git-branch`
+ `git-log`
+ `git-reflog`

See [TEMPLATES](https://github.com/nickolasburr/git-extend/blob/master/TEMPLATES.md) for the complete list of pre-built command wrapper templates.
