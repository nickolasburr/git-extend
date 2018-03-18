# git-extend(1)

`git-extend` is a CLI for extending Git builtins.

## Table of Contents

- [Description](#description)
- [FAQs](#faqs)
- [Installation](#installation)
  + [Homebrew](#homebrew)
  + [Manual](#manual)
    - [`make build`](#make-build)
    - [`make install`](#make-install)
- [Configuration](#configuration)
- [Caveats](#caveats)
- [Options](#options)
- [Examples](#examples)
- [Closures](#closures)
- [Notes](#notes)
- [See Also](#see-also)

## Description

`git-extend` extends Git builtins via [closures](#closures)<sup>1</sup>. Simply put, it provides an interface for user-defined functionality.

## FAQs

> How is this different from using git-config variables?

`git-config` variables are preselected. `git-extend` augments Git builtins with options and functionality _you specify_.

> What advantages does git-extend provide that I can't get from git-config?

With `git-config`, you're confined to variables designated for the builtin. There is [no builtin override](http://git.661346.n2.nabble.com/allowing-aliases-to-override-builtins-to-support-default-options-td2438491.html), so the alternative is to define an alias.
With `git-extend`, user-defined options and functionality wrap the builtin, providing convenient control over invocation context.

> What advantages does git-extend provide that I can't get from a shell alias? Or a shell function?

A shell alias is just that - an alias you have to remember, or look up. A shell function works, but isn't truly scalable.

> What about hooks?

Hooks are great for certain actions, but are predetermined and, therefore, limited.

> Can I still use builtin options for the command?

Absolutely, that's the point of `git-extend`. It can be viewed as a type of closure, providing _additional_ context.

## Installation

<blockquote>
<h3>Important: Please read the <a href="#caveats">Caveats</a> section before continuing.</h3>
</blockquote>

## Homebrew

```
brew tap nickolasburr/pfa
brew install git-extend
```

## Manual

```
git clone https://github.com/nickolasburr/git-extend.git
cd git-extend
make build
make install
```

Outlined below are the two (2) `make` steps needed for installation:

+ `make build`
+ `make install`

#### `make build`

`git-extend` uses an absolute path to invoke `git`. By default, the path is `/usr/bin/git`, and can be modified at build.

The install prefix for `git` is represented by `GITPREFIX`, and defaults to `/usr`. Git is typically prefixed at `/usr` and/or `/usr/local`.

As an example, if the executable is located at `/usr/local/bin/git`, run:

```
make build GITPREFIX=/usr/local
```

If the executable is located at `/usr/bin/git`, simply run `make`.

#### `make install`

The install prefix for `git-extend` is represented by `PREFIX`, and defaults to `/usr/local`.

The following are installed and symlinked in `PREFIX`:

+ `$PREFIX/bin`
+ `$PREFIX/bin/git-extend`
+ `$PREFIX/bin/git-extend` -> `$PREFIX/bin/git`

To install `git-extend` under an alternate prefix, pass `PREFIX` to `make install`.

## Pitfalls

Common installation pitfalls to be mindful of:

+ Installing `git-extend` to the same directory where `git` is installed. `git-extend` creates a symlink to `git`, so `GITPREFIX` and `PREFIX` cannot be the same.
+ Installing to a directory that is not writable by the user. It is **not recommended** to install using `sudo`, but instead to pick an alternate location owned by the user.

Once installed, add `$PREFIX/bin` to your `PATH`. It is important for the `git-extend` symlink to be the **first** `git` resolved in your `PATH`. You can validate this by running `type -all git` or `git extend --path`.

## Configuration

Configuration is straightforward. To use a command closure, name the file accordingly, add it to your `PATH`, and make it executable.

For more details on closures, see [Closures](#closures).

## Caveats

Below are important caveats and considerations to think about prior to installation:

+ Use `git-extend` judiciously. It's intended to be lightweight enough you forget it's there.
+ When in doubt, use `--bypass`. It's equivalent to invoking `git` directly. See [Examples](#examples) for usage.
+ Prefer Interrogators over Manipulators.
+ When building command closures:
  - Only add options and functionality you will _actually_ use, and use _frequently_.
  - Invoke `$GIT`, not `git`. The `GIT` export includes git(1) options and arguments (e.g. `git -C /path/to/repo ...`).
  - Give due diligence to user-defined options. **Don't add options defined by the builtin.**
  - **Always** test command closures somewhere safe before using them in your workflow.

**Homebrew Users**

+ The `git-extend` formula is [keg-only](https://docs.brew.sh/FAQ#what-does-keg-only-mean). Add `/usr/local/opt/git-extend/bin` to your `PATH`.
+ If Git is installed via Homebrew, `git-extend` will use it instead of the system version.

## Options

+ `--bypass`: Invoke `git` directly.
+ `extend`: `git-extend` specific options.
  - `--list`, `-l`: List all `git-*` executables found in `PATH`<sup>2</sup>.
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

3. Bypass `git-log` command closure and get the last five log entries.

    ```
    git --bypass log --max-count=5
    ```

4. Merge the previous branch into `master` and, upon successful merge, delete the previous branch (see [`git-merge`](https://github.com/nickolasburr/git-extend/blob/master/templates/git-merge)).

    ```
    git checkout master
    git merge --no-ff --trim -
    ```

## Closures

A command closure is an executable script that provides additional context when invoking a Git builtin. In order for `git-extend` to use a closure, the file must be:

+ Named to match the corresponding builtin (e.g. `git-log` for `git log`, `git-add` for `git add`, etc.)
+ Reachable from the `PATH` of the user
+ Executable

To verify a command closure is usable, run `type -all git-<COMMAND>`, where `<COMMAND>` is the name of the corresponding Git command.

Templates are provided for several porcelain commands, including:

+ `git-add`
+ `git-branch`
+ `git-diff`
+ `git-log`
+ `git-merge`
+ `git-reflog`
+ `git-status`

For a complete list of pre-built command closures, see [TEMPLATES](https://github.com/nickolasburr/git-extend/blob/master/TEMPLATES.md).

While the aim is to augment existing commands, closures are not limited to builtins. In fact, you can create arbitrary Git commands with the conventions outlined above, and `git-extend` will handle accordingly.

## Notes

1. The term _closure_ is used loosely in the context of `git-extend`. Think closure in terms of an executable as a function.
2. A typical Git installation includes shell scripts, which may show when running `git extend --list`.

## See Also

[git(1)](https://git-scm.com/docs/git), [git-config(1)](https://git-scm.com/docs/git-config)
