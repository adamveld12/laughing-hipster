# nvim-lspconfig

[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

Status: **UNCONFIGURED** — `config.d/lua/lsp.lua` is almost entirely commented out, so no language
server is attached today. Installing this plugin alone does nothing.

## What it does

Ships the connection details for ~300 language servers — the command to launch each one, which
filetypes it handles, and how to find a project root. Neovim has the LSP client built in; this
plugin only supplies the per-server boilerplate.

## 80/20 usage

To activate a server, enable it and install the server binary separately:

```lua
vim.lsp.enable('gopls')        -- Neovim 0.11+ API
vim.lsp.enable('lua_ls')
```

The buffer-local keymaps are already written, commented, in `lsp.lua` — uncommenting that
`LspAttach` autocmd gives you:

| Key | Does |
|---|---|
| `gd` / `gD` | go to definition / declaration |
| `gr` | references |
| `gi` | implementations |
| `K` | hover docs |
| `<space>rn` | rename symbol across the project |
| `<space>ca` | code action |
| `<space>f` | format buffer |
| `[d` / `]d` | previous / next diagnostic |

Note those stock mappings use `<space>`, while this config's leader is `,` — worth reconciling
when you enable them.

| Command | Does |
|---|---|
| `:checkhealth vim.lsp` | what is attached, and why something is not |
| `:LspInfo` | servers active for this buffer |

## When to use

- **Any project big enough that grep is not enough.** `gd` and `gr` on a symbol are the payoff.
- **Renaming across a codebase** — `<space>rn` updates every reference through the server, not
  by text substitution.
- **Replacing syntastic**, which was cut for this. Diagnostics now arrive asynchronously from the
  server instead of blocking the UI.

Servers must be installed yourself (`brew install gopls`, `go install`, etc.); this plugin does
not install them.
