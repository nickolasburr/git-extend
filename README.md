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

`git-extend` extends Git builtins via [command wrappers](#command-wrappers). Simply put, it provides an interface for user-defined functionality.

Now, you may ask yourself:

> How is this different from using git-config variables?

With `git-extend`, you're augmenting Git builtins with options and functionality _you want to use_, regardless of whether git-config offers the capability or not.

> What advantages does git-extend provide that I can't get from git-config?

With git-config, you're confined to the configuration variables for the builtin. There is no builtin override via git-config, so the alternative is to define an alias.

> What advantages does git-extend provide that I can't get from a shell alias? Or a shell function?

A shell alias is just that - an alias you have to remember in order to get value from it. A shell function is not scalable.

> Wouldn't it make more sense to use a hook?

Hooks serve a noble purpose, but they have limited use cases and don't provide granular control.

## Installation

<strong>Important</strong>: Please read the [Caveats](#caveats) section before continuing.

Once you've read the **Caveats** section, you can install `git-extend` via Homebrew or manually.

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

The install prefix is represented by `PREFIX`, and defaults to `/usr/local`. The following files and symlinks are installed in `PREFIX`:

+ `$PREFIX/bin/git-extend`
+ `$PREFIX/share/man/man1/git-extend.1.gz`
+ `$PREFIX/bin/git-extend` -> `$PREFIX/bin/git`

You can install to an alternate location by passing `PREFIX` to `make install`. For example, `make install PREFIX=$HOME/.usr`.

Once installed, verify `$PREFIX/bin` is added to your `PATH`. To install command wrappers, simply place them somewhere in your `PATH`.

<strong>Important</strong>: If a `git` executable is encountered during installation, the process will exit immediately. This will happen if you already have Git installed at `$PREFIX/bin/git`. In this event, install to an alternate location.

## Caveats

A few important caveats and suggestions to consider prior to installation:

+ Use `git-extend` judiciously. Don't go buckwild, it defeats the purpose of the tool.
+ Prefer Interrogators over Manipulators.
+ When adding your own options to a command wrapper, give it due diligence. **Don't add options the builtin already defines.**
+ **Always** test command wrappers somewhere safe before using them in your workflow.
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
