# nvim-treesitter

[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Status: **installed on the `main` branch** — a full incompatible rewrite. The
`require('nvim-treesitter.configs').setup{}` call most guides still show is `master`-branch API
and does not exist here.

## What it does

Installs tree-sitter parsers and the query files that drive syntax highlighting, folding and
indentation. The parsers build a real syntax tree, so highlighting is structural rather than
regex-guessed — a function name is highlighted because it *is* a function name.

Note the division of labour on `main`: this plugin supplies parsers and queries; the
highlighting itself is Neovim's (`:h treesitter-highlight`).

## 80/20 usage

Configured in `config.d/lua/treesitter.lua`:

```lua
require('nvim-treesitter').install({ 'go', 'lua', 'typescript', ... })  -- async, no-op if present

vim.api.nvim_create_autocmd('FileType', {          -- highlighting is Neovim's, not the plugin's
  pattern = languages,
  callback = function() pcall(vim.treesitter.start) end,
})
```

| Command | Does |
|---|---|
| `:TSInstall <lang>` | install one parser |
| `:TSUpdate` | rebuild all parsers — **required after every plugin update** |
| `:TSLog` | installation log when a parser fails to build |
| `:InspectTree` | show the parse tree for the current buffer |
| `:Inspect` | what highlight group is under the cursor, and why |

Requires `tree-sitter-cli` >= 0.26.1 and a C compiler. `plugins/nvim/nvim.sh` installs the CLI
via brew — it must be the brew formula, **not** the npm package. This plugin does not support
lazy-loading.

## When to use

- **Any language you edit regularly.** Add it to the `languages` list in `treesitter.lua`; it
  replaces whatever regex syntax file Neovim was falling back on.
- **Debugging highlighting.** `:Inspect` names the capture responsible for the colour under the
  cursor, which turns "why is this the wrong colour" into a one-step answer.
- **Confirming a parser actually works.** `:InspectTree` — if the tree has `ERROR` nodes, the
  parser is mismatched and `:TSUpdate` is the fix.

## Gotcha

Headless checks with `vim.inspect_pos` report no highlights even when everything works, because
highlights are computed on redraw and headless never redraws. Query the tree directly instead —
see `cut-list.md` for a working check.
