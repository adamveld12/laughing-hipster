# vim-fugitive

[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)

## What it does

Git from inside the buffer. Instead of shelling out and losing your place, you stage hunks, read
blame, and resolve conflicts in normal Vim windows that understand Git objects as buffers.

## 80/20 usage

| Command | Does |
|---|---|
| `:Git` | interactive status window — the main entry point |
| `s` / `u` / `-` | in the status window: stage, unstage, toggle the item under the cursor |
| `=` | in the status window: expand the inline diff for that file |
| `cc` | in the status window: commit what is staged |
| `:Git blame` | blame in a scrollbound sidebar; `Enter` opens that commit |
| `:Gdiffsplit` | three-way diff of the current file against the index |
| `:Gread` / `:Gwrite` | discard working changes / stage the whole file |
| `:Git log -- %` | history of just this file |

In a conflict, `:Gdiffsplit!` opens both parents; `:diffget //2` takes the target-branch side,
`:diffget //3` takes the merging side.

## When to use

- **Resolving a merge conflict.** Three-way diff plus `:diffget //2` and `//3` beats hand-editing
  conflict markers, and you never leave the file.
- **Building a commit out of a messy working tree.** `:Git`, then `=` to inspect and `s` to stage
  file by file, reviewing as you go.
- **Archaeology.** `:Git blame` on a confusing line, `Enter` to open that commit, and repeat
  backwards through history without touching the shell.
