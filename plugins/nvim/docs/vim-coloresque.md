# vim-coloresque

[gorodinskiy/vim-coloresque](https://github.com/gorodinskiy/vim-coloresque)

Status: **UNMAINTAINED** — no meaningful upstream activity in years. Kept because Neovim has no
built-in equivalent.

## What it does

Renders colour values in the buffer with their actual colour as the background, so `#3fb950`
appears green rather than as a hex string. Works with hex, `rgb()`, `rgba()`, `hsl()` and CSS
colour names.

## 80/20 usage

There is nothing to configure — it activates on filetypes where colour values are likely
(css, scss, less, html, javascript, and others).

| Command | Does |
|---|---|
| `:ColorHighlight` | force highlighting on in the current buffer |
| `:ColorClear` | turn it off for this buffer |
| `:ColorToggle` | flip it |

Needs `termguicolors`, which this config sets in `init.lua`. Without it the previews fall back to
the nearest of 256 terminal colours and are misleading.

## When to use

- **Editing a stylesheet or a theme file**, where the question is constantly "which green is
  this?" and the answer is otherwise a round trip to a browser.
- **Auditing a palette** — open the variables file and see the whole set at once, including the
  two near-identical greys someone added by accident.
- **Working on this repo's colorschemes** or terminal configs, where hex values are dense and
  named colours are rare.

Modern alternatives with more features: `nvim-colorizer.lua`, `ccc.nvim`.
