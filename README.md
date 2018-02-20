# git-extend(1)

`git-extend` is a lightweight wrapper for Git builtins.

## Table of Contents

- [Description](#description)
- [Purpose](#purpose)
- [Caveats](#caveats)
- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
- [Options](#options)
- [Examples](#examples)
- [Command Wrappers](#command-wrappers)

## Description

`git-extend` extends Git builtins via [command wrappers](#command-wrappers). It is intended for the individual who wants to use Git builtins organically, with a tinge of customization.

## Purpose

Git can be quite unintuitive, at times. Options you think should exist, do not. Tasks you think should be simple, are not. For many, a few extra convenience options is highly desirable.

Now, you may ask yourself:

> How is this different from using git-config aliases?

--OR--

> What advantages does git-extend provide that I can't get from git-config? Or from a shell alias?

The difference is, with `git-extend`, you're augmenting Git builtins, not defining aliases you won't remember. The advantages are convenience, efficiency, and intuitiveness.

## Caveats

A few important caveats to consider prior to installation:

+ When adding options to a command wrapper, make sure the builtin doesn't have an equivalent option. This will cause conflicts otherwise.
+ When in doubt, use `--bypass`. See [Examples](#examples) for `--bypass` usage.
+ **Always** test command wrappers somewhere safe before using them in your workflow. If you don't, bad things _will_ happen.

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

The installation directory is represented by `$PREFIX`, and defaults to `/usr/local`. The following files are installed in `$PREFIX`:

+ `$PREFIX/bin/git-extend`
+ `$PREFIX/share/man/man1/git-extend.1.gz`

You can install to an alternate location by passing `PREFIX` to `make install`. For example, `make install PREFIX=$HOME/.usr`.

Additionally, the following files are symlinked in `$PREFIX`:

+ `$PREFIX/bin/git-extend` -> `$PREFIX/bin/git`

<div style="color: red; font-weight: bold">Important</div>: If a `git` executable is encountered during `make install`, the process will fail. This will happen if you have Git installed at `$PREFIX/bin/git`. In this event, run `make uninstall` and use `PREFIX` to specify an alternate location, then add that pathname to the beginning of your `$PATH`.

## Options

+ `--bypass`: Bypass all `git-extend` command wrappers.

## Examples

1. Get the name of the previous branch (assumes pre-built command wrapper for `git-branch`).

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

2. Add the first pathspec in the list derived from `git-status` (assumes pre-built command wrapper for `git-add`).

    ```
    git add %1
    ```

3. Bypass `git-extend` and get the last five log entries.

    ```
    git --bypass log --max-count=5
    ```

## Command Wrappers

Command wrappers are executable scripts with the same name as a Git builtin. For example, `git-log` for `git log`, `git-add` for `git add`, and so on.

Templates are provided for several porcelain commands, including:

+ `git-add`
+ `git-branch`
+ `git-log`
+ `git-reflog`

See [TEMPLATES](https://github.com/nickolasburr/git-extend/blob/master/TEMPLATES.md) for a complete list of pre-built command wrapper templates.
