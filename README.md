# git-extend(1)

`git-extend` is a featherweight wrapper for Git builtins.

## Table of Contents

- [Description](#description)
- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
- [Caveats](#caveats)
- [Options](#options)
- [Examples](#examples)
- [Command Wrappers](#command-wrappers)

## Description

`git-extend` extends Git builtins via [command wrappers](#command-wrappers). In other words, it provides an interface for user-defined functionality around Git builtins. It is intended for the individual who prefers to use Git builtins organically, but is okay with muddying the waters a bit to make certain tasks easier.

Now, you may ask yourself:

> How is this different from using git-config aliases?

--OR--

> What advantages does git-extend provide that I can't get from git-config? Or a shell alias?

The difference is, with `git-extend`, you're augmenting Git builtins with options and functionality _you wish it had_ (and, therefore, will remember), instead of defining aliases and functions you're less likely to use.

## Installation

<strong>Important</strong>: Please read the [Caveats](#caveats) section before installing.

You can install `git-extend` via Homebrew or manually.

### Homebrew

```
brew tap nickolasburr/pfa
brew install git-extend
```

### Manual

```
git clone https://github.com/nickolasburr/git-extend.git
cd git-extend
make
make install
```

The installation directory is represented by `$PREFIX`, and defaults to `/usr/local`. The following files are installed in `$PREFIX`:

+ `$PREFIX/bin/git-extend`
+ `$PREFIX/share/man/man1/git-extend.1.gz`

You can install to an alternate location by passing `PREFIX` to `make install`. For example, `make install PREFIX=$HOME/.usr`.

Additionally, the following files are symlinked in `$PREFIX`:

+ `$PREFIX/bin/git-extend` -> `$PREFIX/bin/git`

<strong>Important</strong>: If a `git` executable is encountered during `make install`, the process will fail. This will happen if you have Git installed at `$PREFIX/bin/git`. In this event, run `make uninstall` and use `PREFIX` to specify an alternate location, then add that pathname to the beginning of your `$PATH`.

## Caveats

A few important caveats and suggestions to consider prior to installation:

+ Use `git-extend` judiciously. Don't go buckwild, it defeats the purpose of the tool.
+ When adding your own options to a command wrapper, make sure the builtin **does not have an equivalent option**. Otherwise, this can and will lead to **unexpected behavior**.
+ **Always** test command wrappers somewhere safe before using them in your workflow. If you don't, bad things _will_ happen.
+ When in doubt, use `--bypass`. See [Examples](#examples) for `--bypass` usage.

## Options

+ `--bypass`: Bypass all `git-extend` command wrappers.

## Examples

1. Get the name of the previous branch (see [`git-branch`](https://github.com/nickolasburr/git-extend/blob/master/templates/git-branch)).

    ```
    git branch --last
    ```

2. Add the first pathspec in the list derived from [`git-status --numbered`](https://github.com/nickolasburr/git-extend/blob/master/templates/git-status#L19-L36) (see [`git-add`](https://github.com/nickolasburr/git-extend/blob/master/templates/git-add)).

    ```
    git add %1
    ```

3. Bypass `git-log` wrapper and get the last five log entries.

    ```
    git --bypass log --max-count=5
    ```

## Command Wrappers

As one might anticipate, a command wrapper is an executable script with the equivalent name of its Git builtin counterpart. For example, `git-log` for `git log`, `git-add` for `git add`, and so on.

Templates are provided for several porcelain commands, including:

+ `git-add`
+ `git-branch`
+ `git-diff`
+ `git-log`
+ `git-merge`
+ `git-reflog`
+ `git-status`

For a complete list of pre-built wrappers, see [TEMPLATES](https://github.com/nickolasburr/git-extend/blob/master/TEMPLATES.md).
