# Colorschemes

The 14 theme plugins in `config.d/lua/plugins.lua`, in one file — per-theme docs would repeat
`:colorscheme <name>` fourteen times. See `AGENTS.md` for why this is the one exception to
one-file-per-plugin.

**`ecostation` is the active one**, set at the bottom of `config.d/init.lua`. That call is wrapped
in `pcall` because the theme ships via packer and is missing until `:PackerSync` has run — an
unguarded `colorscheme` aborts startup on a fresh machine.

## The themes

The `:colorscheme` name often differs from the repo name — that column is the one you actually
type.

| `:colorscheme` | Repo | Bg | Notes |
|---|---|---|---|
| `ecostation` | [vim-scripts/ecostation](https://github.com/vim-scripts/ecostation) | dark | **active**; muted green-grey |
| `gruvbox-material` | [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material) | both | best-maintained of the set; warm, low contrast |
| `jellybeans` | [nanotech/jellybeans.vim](https://github.com/nanotech/jellybeans.vim) | dark | long-standing dark theme, good 256-colour fallback |
| `monokai` | [lsdr/monokai](https://github.com/lsdr/monokai) | dark | the TextMate/Sublime classic |
| `solarized` | [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) | both | **archived upstream**; `set background=light` for the light variant |
| `inkpot` | [ciaranm/inkpot](https://github.com/ciaranm/inkpot) | dark | purple-tinted |
| `obsidian` | [trevorrjohn/vim-obsidian](https://github.com/trevorrjohn/vim-obsidian) | dark | dark blue-grey |
| `wombat256i` | [dsolstad/vim-wombat256i](https://github.com/dsolstad/vim-wombat256i) | dark | 256-colour wombat variant |
| `rdark` | [vim-scripts/rdark](https://github.com/vim-scripts/rdark) | dark | stale vim-scripts mirror |
| `vilight` | [vim-scripts/vilight.vim](https://github.com/vim-scripts/vilight.vim) | dark | stale vim-scripts mirror |
| `dragon-energy` | [wdhg/dragon-energy](https://github.com/wdhg/dragon-energy) | dark | high contrast |
| `cmptrclr` | [FrancescoMagliocco/CmptrClr](https://github.com/FrancescoMagliocco/CmptrClr) | dark | note the lowercase name |
| `Tomorrow` *(+4)* | [chriskempson/vim-tomorrow-theme](https://github.com/chriskempson/vim-tomorrow-theme) | both | also `Tomorrow-Night`, `-Night-Blue`, `-Night-Bright`, `-Night-Eighties`. Capitalised. |
| `patagonia` *(+8)* | [cjgajard/patagonia-vim](https://github.com/cjgajard/patagonia-vim) | dark | also ships `anaglyph`, `cobalt`, `monored`, `ox`, `ponponpon`, `superchat`, `trescolores`, `turboc` |

That is 27 selectable schemes from 14 plugins.

## 80/20 usage

| Command | Does |
|---|---|
| `:colorscheme <name>` | switch for this session |
| `:colorscheme <Tab>` | cycle through every installed name |
| `:colorscheme` | print the current one |
| `set background=light` / `dark` | flip the variant, for themes that have both |
| `:Inspect` | which highlight group is under the cursor (treesitter-aware) |

To change the default, edit the last line of `config.d/init.lua`:

```lua
pcall(vim.cmd.colorscheme, 'ecostation')
```

Keep the `pcall`. Without it, a typo or a not-yet-synced theme takes down startup.

This config sets `termguicolors`, so themes render in 24-bit colour. Most of these predate
`termguicolors` and were written for 256-colour terminals — the older vim-scripts ones in
particular may look flatter than their screenshots.

## When to use

- **Reaching for a different theme:** `:colorscheme <Tab>` and cycle. Nothing is committed until
  you edit `init.lua`, so it is free to browse.
- **Light environments:** only `gruvbox-material`, `solarized` and `Tomorrow` have real light
  variants. The rest are dark-only, and `set background=light` will not rescue them.
- **A new terminal or font:** check the theme still reads well. These were tuned across a wide
  span of years and terminal capabilities.

## Status notes

- `altercation/vim-colors-solarized` is **archived**. `maxmartinez/solarized8` or
  `ishan9299/nvim-solarized-lua` are maintained ports with treesitter support.
- The four `vim-scripts/*` entries (`ecostation`, `rdark`, `vilight.vim`, plus the cut
  `matchit.zip`) are **stale mirrors** of the old vim.org script archive, not upstream repos. They
  are frozen, which is fine for a colorscheme and was not for `matchit.zip` — see `cut-list.md`.
- None of these define treesitter highlight groups (`@function`, `@keyword.import`, …). Neovim
  falls back to the legacy groups, so treesitter highlighting works but is less granular than a
  modern theme would give you. `gruvbox-material` is the exception and the one to prefer if that
  matters.
