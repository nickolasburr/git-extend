# Command Wrapper Templates

Below is a list of pre-built command wrappers with example usage, to help illustrate how `git-extend` works.

Template files are located in the [templates](https://github.com/nickolasburr/git-extend/tree/master/templates) directory.

## Pre-built Templates

- [`git-add`](#git-add)
- [`git-branch`](#git-branch)
- [`git-diff`](#git-diff)
- [`git-log`](#git-log)
- [`git-merge`](#git-merge)
- [`git-reflog`](#git-reflog)
- [`git-status`](#git-status)

1. **`git-add`**
    + `%n`: Add pathspec at index `n`, referenced via the list derived from [`git status --numbered`](https://github.com/nickolasburr/git-extend/blob/master/templates/git-status#L19-L36). Index starts at `1`.

    ```
    git add %1
    ```

2. **`git-branch`**
  + `--last`, `-L`: Get the name of the last branch.

    ```
    git branch --last
    # -> fix/bug
    ```

3. **`git-diff`**
  + `--sxs`: Show side-by-side diff.

    ```
    git diff --sxs
    ```

4. **`git-log`**
  + `--all`: Get all commits (overrides initial `--max-count=$NUM`).
  + `--last`: Get last `n` commits (overrides initial `--max-count=$TOTAL`).

    ```
    git log --last 15
    ```

5. **`git-merge`**
  + `--trim`, `-T`: Delete the previous branch after a successful merge (if applicable).

    ```
    git merge --no-ff --trim -
    ```

6. **`git-reflog`**
  + `--all`: Get all commits (overrides initial `--max-count=$NUM`).
  + `--last`: Get last `n` commits (overrides initial `--max-count=$TOTAL`).

    ```
    git reflog --all
    ```

7. **`git-status`**
  + `--numbered`, `-N`: Get an ordered list of unstaged and untracked files in the worktree. Intended to be used with [`git-add`](#git-add).

    ```
    git status --numbered

    # -> 1. M apply.c
         2. M merge.c
         3. ?? rebase.c
    ```
