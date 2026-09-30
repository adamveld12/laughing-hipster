# NERDTree

[preservim/nerdtree](https://github.com/preservim/nerdtree)

Formerly `scrooloose/nerdtree`; the repo moved orgs and the spec was updated to match.

## What it does

A file-system tree in a sidebar, with filesystem operations (add, move, delete, copy) available
from the tree itself.

## 80/20 usage

Bindings from `config.d/init.lua` (leader is `,`):

| Key | Does |
|---|---|
| `,n` | toggle the tree, rooted at the current file's directory |
| `,m` | close, then reopen focused on the current file |

Inside the tree:

| Key | Does |
|---|---|
| `o` / `<CR>` | open file, or expand/collapse a directory |
| `s` / `i` | open in a vertical / horizontal split |
| `t` | open in a new tab |
| `m` | filesystem menu — add, move, delete, copy |
| `R` | refresh the tree from disk |
| `C` | make the directory under the cursor the new root |
| `u` | move the root up one level |
| `I` | toggle hidden files |
| `?` | built-in help |

## When to use

- **Getting your bearings in an unfamiliar repo**, where you want the shape of the tree rather
  than a fuzzy-find on a name you don't know yet.
- **Filesystem work mid-edit** — `m` renames and moves files without a shell.
- **"Where am I?"** — `,m` reveals the current buffer in the tree when you have lost the thread.

For opening a file you can already name, telescope's `<C-P>` is faster. The two complement each
other: browse with NERDTree, jump with telescope.
