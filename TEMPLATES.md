# git-extend(1) Templates

## Available Templates

- [`git-add`](#git-add)
- [`git-branch`](#git-branch)
- [`git-log`](#git-log)
- [`git-reflog`](#git-reflog)

## `git-add`

+ `%n`, where `n` is the index number of the file to add from `git-status` output. Index starts at `1`.

**Usage:**

```
git add %1
```

## `git-branch`

+ `--last`, `-L`: Get the name of the last branch.

**Usage:**

```
git branch --last
```
