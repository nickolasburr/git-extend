# git-extend(1)

`git-extend` is a featherweight wrapper for Git builtins.

## Table of Contents

- [Description](#description)
- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
    - [`make build`](#make-build)
    - [`make install`](#make-install)
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

## Homebrew

```
brew tap nickolasburr/pfa
brew install git-extend
```

## Manual

**To ensure proper installation, please read this section in its entirety.**

```
git clone https://github.com/nickolasburr/git-extend.git
cd git-extend
make build
make install
```

#### `make build`

`git-extend` uses an absolute path to invoke `git`. By default, the path is `/usr/bin/git`.

The install prefix for `git` is represented by `GITPREFIX`, and defaults to `/usr`. Git is typically installed under `/usr` and/or `/usr/local`.

As an example, if your `git` executable is located at `/usr/local/bin/git`, you would run:

```
make build GITPREFIX=/usr/local
```

If your `git` executable is located at `/usr/bin/git`, then you can simply run `make`.

<strong>Important</strong>: If you don't have Git installed, you need to so before continuing. `git-extend` **does not** install Git for you.

#### `make install`

The install prefix for `git-extend` is represented by `PREFIX`, and defaults to `/usr/local`.

The following are installed and symlinked in `PREFIX`:

+ `$PREFIX/bin`
+ `$PREFIX/bin/git-extend`
+ `$PREFIX/bin/git-extend` -> `$PREFIX/bin/git`

You can install to an alternate location by passing `PREFIX` to `make install`. For example, `make install PREFIX=/usr/local/git-extend`.

<strong>Important</strong>: Common issues which cause installation to exit prematurely include:

+ Installing `git-extend` to the same directory where `git` is installed. Remember, `git-extend` creates a `$PREFIX/bin/git-extend` -> `$PREFIX/bin/git` symlink, so `GITPREFIX` and `PREFIX` cannot be the same!
+ Installing to a directory that is not writable by the user. It is **not recommended** to install using `sudo`, but instead to pick an alternate location owned by the user.

Once installed, add `$PREFIX/bin` to your `PATH`. It is important `git-extend` is the **first** `git` executable resolved in your `PATH`. You can validate this by running `type -all git` or `git extend --path`.

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
  - `--path`, `-p`: Get absolute path to `git` symlink.
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
