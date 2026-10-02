# telescope.nvim

[nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## What it does

A fuzzy finder over anything that can be listed — files, buffers, grep results, help tags, LSP
symbols — in a floating window with a live preview. Replaced `ctrlp.vim` in this config; see
`cut-list.md`.

## 80/20 usage

Bindings from the TELESCOPE section of `config.d/init.lua` (leader is `,`). `<C-P>`, `<C-f>`,
`,tp` and `,tf` search from the current buffer's git root (falling back to the cwd), so they
see the whole repo even though `autochdir` keeps the cwd at the current file's folder:

| Key | Picker |
|---|---|
| `<C-P>` | `find_files` — same key ctrlp used |
| `<C-f>` | `live_grep` — search file *contents* as you type |
| `,tp` / `,tf` | `find_files` / `live_grep`, but `<CR>` opens the result in a new tab |
| `,fb` | `buffers` |
| `,fh` | `help_tags` |

Inside a picker:

| Key | Does |
|---|---|
| `<C-n>` / `<C-p>` | next / previous result |
| `<CR>` | open in a new vertical split (new tab under `,tp` / `,tf`) |
| `<C-o>` | open in the current window, replacing it |
| `<C-x>` / `<C-v>` / `<C-t>` | open in split / vsplit / new tab |
| `<C-u>` / `<C-d>` | scroll the preview |
| `<Tab>` | multi-select, then `<C-q>` sends the selection to quickfix |
| `<Esc>` | close (press twice from insert) |

Results never open inside the NERDTree window; picking from there uses the first regular
window in the tab instead. `live_grep` needs `ripgrep` on `PATH`. `find_files` respects `.gitignore` when `fd` or `rg` is
available.

## When to use

- **Opening a file you can only half-remember.** `<C-P>` then fragments of the name; the preview
  confirms before you commit.
- **Finding where a symbol is used** across a repo with `<C-f>`, then `<Tab>` to mark the
  interesting hits and `<C-q>` to turn them into a quickfix list to work through.
- **Reading docs without leaving the buffer** — `,fh` searches help tags with the help text
  previewed live.
