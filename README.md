# git-extend(1)

`git-extend` is a featherweight wrapper for Git builtins.

## Table of Contents

- [Description](#description)
- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
- [Configuration](#configuration)
- [Caveats](#caveats)
- [Options](#options)
- [Examples](#examples)
- [Command Wrappers](#command-wrappers)

## Description

`git-extend` extends Git builtins via [command wrappers](#command-wrappers). Simply put, it provides an interface for user-defined functionality.

Now, you may ask yourself:

> How is this different from using git-config variables?

With git-config, variables are limited and predetermined. With `git-extend`, you augment Git builtins with any options and functionality _you want_.

> What advantages does git-extend provide that I can't get from git-config?

With git-config, you're confined to variables set forth for the builtin. There is no builtin override, so the alternative is to define an alias. With `git-extend`, user-defined options and functionality sit above the Git builtin, allowing you to control behavior as you see fit.

> What advantages does git-extend provide that I can't get from a shell alias? Or a shell function?

A shell alias is just that - an alias you have to remember or look up. A shell function works, but isn't very scalable.

> Why not make use of hooks?

Hooks serve their purpose, but they're limited by design.

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
+ `$PREFIX/bin/git-extend` -> `$PREFIX/bin/git`
+ `$PREFIX/share/man/man1/git-extend.1.gz`

You can install to an alternate location by passing `PREFIX` to `make install`. For example, `make install PREFIX=$HOME/.usr`.

<strong>Important</strong>: If a `git` executable is encountered during installation, the process will exit immediately. This will happen if:

+ You already have `git-extend` installed and symlinked at `$PREFIX/bin/git`. You can use `--force` to overwrite during installation. Be careful!
+ You used `PREFIX` to specify an alternate location and a `git` executable is already installed there. In this case, simply install to a different location.

Once installed, verify `$PREFIX/bin` is added to your `PATH`. It is important `git-extend` is the **first `git` executable found in your `PATH`**. You can check this by running `type -all git`.

## Configuration

Configuration is straightforward. To use a command wrapper, name the file accordingly, add it anywhere in your `PATH`, and make it executable.

For more details on command wrappers, see [Command Wrappers](#command-wrappers).

## Caveats

Below are important caveats and considerations to think about prior to installation:

+ Use `git-extend` judiciously. It's lightweight - keep it that way.
+ Prefer Interrogators over Manipulators.
+ When building command wrappers:
  - Only add options and functionality you will _actually_ use, and use frequently.
  - Use `$GIT` instead of `git`. The `GIT` export includes git(1) options and arguments.
  - Give due diligence to user-defined options. **Don't add options already defined by the builtin.**
  - **Always** test command wrappers somewhere safe before using them in your workflow.
+ When in doubt, use `--bypass`. It's equivalent to invoking `git` directly. See [Examples](#examples) for usage.

## Options

+ `--bypass`: Bypass all `git-extend` command wrappers.
+ `extend`: `git-extend` specific options.
  - `--list`, `-l`: List all `git-*` executables found in `PATH`.
  - `--help`, `-h`: Show usage information.
  - `--version`, `-V`: Show current version.

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

4. Merge the previous branch into `master` and, upon successful merge, delete the previous branch (see [`git-merge`](https://github.com/nickolasburr/git-extend/blob/master/templates/git-merge)).

    ```
    git checkout master
    git merge --no-ff --trim -
    ```

## Command Wrappers

As one might anticipate, a command wrapper is an executable script with the equivalent name of its Git builtin counterpart. For example, `git-log` for `git log`, `git-add` for `git add`, and so on.

However, command wrappers are not limited to Git builtins. You can also create arbitrary Git commands using the same conventions, and `git-extend` will resolve the command accordingly.

Templates are provided for several porcelain commands, including:

+ `git-add`
+ `git-branch`
+ `git-diff`
+ `git-log`
+ `git-merge`
+ `git-reflog`
+ `git-status`

For a complete list of pre-built wrappers, see [TEMPLATES](https://github.com/nickolasburr/git-extend/blob/master/TEMPLATES.md).
