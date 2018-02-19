# git-extend(1) Templates

+ **Default** options are Git builtin options given to `git` via the command wrapper. You can add/modify/remove them to your liking.
+ **Wrapper** options are user-defined options which augment input given to `git` via the command wrapper. Make sure to use unique option names to avoid potential conflicts.

## Pre-built Templates

- [`git-add`](#git-add)
- [`git-branch`](#git-branch)
- [`git-log`](#git-log)
- [`git-reflog`](#git-reflog)

### `git-add`

+ `%n`: Add pathspec at index `n`, given output from `git status`. Index starts at `1`.

**Usage:**

```
git add %1
```

### `git-branch`

#### Options

**Default**

_none_

**Wrapper**

+ `--last`, `-L`: Get the name of the last branch.

**Usage:**

```
git branch --last
# -> fix/bug
```

### `git-log`

#### Options

**Default**

+ `--graph`
+ `--abbrev-commit`
+ `--date=relative`
+ `--format="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"`
+ `--max-count=10`

**Wrapper**

+ `--all`: Get all commits (overrides initial `--max-count=$NUM`).
+ `--last`: Get last `n` commits (overrides initial `--max-count=$TOTAL`).

**Usage:**

```
git log --last 15
```

### `git-reflog`

#### Options

**Default**

+ `--abbrev-commit`
+ `--date=relative`
+ `--format="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"`
+ `--max-count=10`

**Wrapper**

+ `--all`: Get all commits (overrides initial `--max-count=$NUM`).
+ `--last`: Get last `n` commits (overrides initial `--max-count=$TOTAL`).

**Usage:**

```
git reflog --all
```
