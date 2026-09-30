# lualine.nvim

[nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

## What it does

Replaces the statusline with a configurable, segmented one written in Lua — mode, branch, file
info, diagnostics, cursor position. Fast enough to not be noticeable, unlike the vimscript
statusline plugins it descends from.

## 80/20 usage

Set up in `config.d/lua/lsp.lua` with stock defaults:

```lua
require('lualine').setup()
```

Defaults give mode, git branch, filename with modified flag, filetype, encoding, and
line:column. To customise, pass a table:

```lua
require('lualine').setup {
  options = { theme = 'auto', section_separators = '', component_separators = '|' },
  sections = { lualine_c = { {'filename', path = 1} } },   -- path = 1 -> relative path
}
```

`theme = 'auto'` follows the active colorscheme. Sections are `lualine_a` through `lualine_x`,
left to right.

## When to use

- **Knowing your branch without asking.** The branch segment is the single highest-value default
  when you work across several at once.
- **Seeing diagnostics counts at a glance** once LSP is configured — errors and warnings surface
  in the statusline instead of needing `:lopen`.
- **Distinguishing splits.** The active window's statusline is highlighted differently, which
  matters once you have three or four open.

Depends on `nvim-web-devicons` for the filetype glyphs.
