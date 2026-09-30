# Neovim plugin docs

One file per plugin in `config.d/lua/plugins.lua`: what it is, what it does, the handful of
commands that cover most real use, and when it earns its place.

Conventions for writing these live in [AGENTS.md](AGENTS.md). Plugins that were removed, and the
evidence for each removal, are in [cut-list.md](cut-list.md).

## Editor and tools

| Plugin | Does | Status |
|---|---|---|
| [telescope](telescope.md) | fuzzy finder over files, grep, buffers, help | |
| [nerdtree](nerdtree.md) | file tree sidebar | moved org: `scrooloose` → `preservim` |
| [fugitive](fugitive.md) | Git from inside the buffer | |
| [dadbod](dadbod.md) | run SQL against a database | |
| [dispatch](dispatch.md) | async builds and tests into quickfix | |
| [presenting](presenting.md) | present a Markdown file as slides | |
| [lualine](lualine.md) | statusline | |

## Editing behaviour

| Plugin | Does | Status |
|---|---|---|
| [xmledit](xmledit.md) | tag-aware XML/HTML editing | unmaintained; nothing built-in replaces it |
| [vim-coloresque](vim-coloresque.md) | render colour values in their own colour | unmaintained; nothing built-in replaces it |

## Language support

| Plugin | Does | Status |
|---|---|---|
| [nvim-treesitter](nvim-treesitter.md) | parsers and queries for structural highlighting | on the `main` branch — incompatible with `master` API |
| [nvim-lspconfig](nvim-lspconfig.md) | connection details for ~300 language servers | **unconfigured** — no server attached |
| [go.nvim](go-nvim.md) | Go test running, codegen, struct tags | **unconfigured** — `setup()` never called |

## Themes

| Doc | Covers |
|---|---|
| [colorschemes](colorschemes.md) | all 14 theme plugins (27 selectable schemes). `ecostation` is active. |

## Infrastructure and dependencies

| Plugin | Does | Status |
|---|---|---|
| [packer](packer.md) | the plugin manager | **archived** Aug 2023; lazy.nvim is the successor |
| [plenary](plenary.md) | Lua stdlib — required by telescope and go.nvim | dependency only |
| [guihua](guihua.md) | floating-window widgets — required by go.nvim | dependency only |
| [nvim-web-devicons](nvim-web-devicons.md) | filetype glyphs — required by lualine | dependency only |

## Needs attention

Three things in the list above are worth acting on, in rough priority order:

1. **nvim-lspconfig is unconfigured.** The keymaps are already written, commented out, in
   `config.d/lua/lsp.lua`. This is the largest unrealised gain here — `syntastic` was cut on the
   basis that LSP replaces it, and that only pays off once a server is enabled.
2. **go.nvim is unconfigured** — one `require('go').setup()` away from working.
3. **packer is archived.** Nothing is broken, but it has no maintainer. Migrating to `lazy.nvim`
   is the eventual fix.
