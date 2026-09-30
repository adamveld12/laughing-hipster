# nvim-web-devicons

[nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

## What it does

Maps filetypes and filenames to glyphs and colours. Plugins call it to put a language icon next
to a filename; on its own it changes nothing.

## 80/20 usage

Declared in `plugins.lua` as lualine's dependency:

```lua
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
}
```

**Requires a Nerd Font** in your terminal, or the glyphs render as tofu boxes. This config's
`guifont` list starts with Pragmata Pro — if you see boxes in the statusline, that is the cause,
not this plugin.

| Call | Returns |
|---|---|
| `require('nvim-web-devicons').get_icon('init.lua')` | the glyph and its highlight group |
| `:lua print(require('nvim-web-devicons').has_loaded())` | whether it initialised |

## When to use

- **Keep it** while lualine is installed, for the filetype icon in the statusline.
- **Remove it** if you work over a terminal without a Nerd Font and would rather have no icons
  than broken ones — lualine degrades gracefully to text-only.
