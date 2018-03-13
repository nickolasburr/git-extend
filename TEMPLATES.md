# Command Wrapper Templates

Below is a list of pre-built command wrappers with example usage, to help illustrate how `git-extend` works.

Template files are located in the [templates](https://github.com/nickolasburr/git-extend/tree/master/templates) directory.

## Option Types

+ **Builtin:**
  - Git builtin options given to `git` via the command wrapper. You can add/modify/remove them to your liking.
+ **User:**
  - User-defined options which augment input given to `git` via the command wrapper. **Use unique option names to avoid conflicts.**

## Pre-built Templates

- [`git-add`](#git-add)
- [`git-branch`](#git-branch)
- [`git-diff`](#git-diff)
- [`git-log`](#git-log)
- [`git-merge`](#git-merge)
- [`git-reflog`](#git-reflog)
- [`git-status`](#git-status)

### `git-add`

+ `%n`: Add pathspec at index `n`, referenced via the list derived from [`git status --numbered`](https://github.com/nickolasburr/git-extend/blob/master/templates/git-status#L19-L36). Index starts at `1`.

**Usage:**

```
git add %1
```

---

### `git-branch`

#### _Options_

+ **Builtin**
  - _none_
+ **User**
  - `--last`, `-L`: Get the name of the last branch.

**Usage:**

```
git branch --last
# -> fix/bug
```

---

### `git-diff`

#### _Options_

+ **Builtin**
  - `--color-words`
  - `--minimal`
+ **User**
  - _none_

---

### `git-log`

#### _Options_

+ **Builtin**
  - `--graph`
  - `--abbrev-commit`
  - `--date=relative`
  - `--format="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"`
  - `--max-count=10`
+ **User**
  - `--all`: Get all commits (overrides initial `--max-count=$NUM`).
  - `--last`: Get last `n` commits (overrides initial `--max-count=$TOTAL`).

**Usage:**

```
git log --last 15
```

---

### `git-merge`

#### _Options_

+ **Builtin**
  - _none_
+ **User**
  - `--trim`, `-T`: Delete the previous branch after a successful merge (if applicable).

**Usage:**

```
git merge --no-ff --trim -
```

---

### `git-reflog`

#### _Options_

+ **Builtin**
  - `--abbrev-commit`
  - `--date=relative`
  - `--format="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"`
  - `--max-count=10`
+ **User**
  - `--all`: Get all commits (overrides initial `--max-count=$NUM`).
  - `--last`: Get last `n` commits (overrides initial `--max-count=$TOTAL`).

**Usage:**

```
git reflog --all
```

---

### `git-status`

#### _Options_

+ **Builtin**
  - _none_
+ **User**
  - `--numbered`, `-N`: Get an ordered list of unstaged and untracked files in the worktree. Intended to be used with [`git-add`](#git-add).

**Usage:**

```
git status --numbered

# -> 1. M apply.c
     2. M merge.c
     3. ?? rebase.c
```
