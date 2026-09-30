# Cut list

Plugins removed from `config.d/lua/plugins.lua` because something already installed does the job.
Every row was verified against a running Neovim 0.12.5 before removal — see `AGENTS.md`, *Evidence
rule*.

To undo any cut, paste its spec line back into `plugins.lua` and run `:PackerSync`.

## Superseded by Neovim's own runtime

Neovim vendors these upstreams. Removing them costs only the delta between Neovim's vendored
snapshot and upstream HEAD.

| Spec line | Replaced by | Evidence |
|---|---|---|
| `use 'vim-scripts/matchit.zip'` | built-in matchit (`:h matchit`) | `nvim_get_runtime_file('plugin/matchit.vim', true)` returns 2 entries — `runtime/plugin/matchit.vim` and `runtime/pack/dist/opt/matchit/` |
| `use 'vim-ruby/vim-ruby'` | bundled `syntax/ruby.vim` | that file's header reads `URL: https://github.com/vim-ruby/vim-ruby` — it *is* this plugin |
| `use 'tpope/vim-markdown'` | bundled `syntax/markdown.vim` | header reads `Maintainer: Tim Pope <https://github.com/tpope/vim-markdown>` |
| `use 'groenewege/vim-less'` | bundled `syntax/less.vim` | resolves from `$VIMRUNTIME` with the plugin removed |
| `use 'cakebaker/scss-syntax.vim'` | bundled `syntax/scss.vim` | resolves from `$VIMRUNTIME` with the plugin removed |
| `use 'tpope/vim-haml'` | bundled `syntax/haml.vim` | resolves from `$VIMRUNTIME` with the plugin removed |
| `use 'oscarh/vimerl'` | bundled `syntax/erlang.vim` | resolves from `$VIMRUNTIME`; plugin also abandoned since 2013 |

## Superseded by other installed plugins

| Spec line | Replaced by | Evidence |
|---|---|---|
| `use 'scrooloose/syntastic'` | built-in LSP diagnostics via `nvim-lspconfig` | syntastic runs checkers synchronously and blocks the UI, and competes with LSP for signs and the location list. Its only config here was `g:syntastic_go_checkers`, which gopls covers. |
| `use 'kien/ctrlp.vim'` | `telescope.nvim` | `kien/` has no commits since 2014. Telescope is faster on large trees and adds live grep and LSP pickers; `plenary.nvim` was already installed as a dependency. |
| `use 'pangloss/vim-javascript'` | treesitter | `javascript` parser installed and its highlight query matches; Neovim also bundles `syntax/javascript.vim` as a fallback |
| `use 'mxw/vim-jsx'` | treesitter | abandoned, and depended on `vim-javascript`. `tsx` and `javascript` parsers cover JSX properly. |

## Config removed alongside

From `config.d/init.lua`:

- the seven `vim.g.ctrlp_*` assignments — `ctrlp_map`, `ctrlp_cmd`, `ctrlp_extensions`,
  `ctrlp_show_hidden`, `ctrlp_working_path_mode`, `ctrlp_by_filename`, `ctrlp_max_files`,
  `ctrlp_custom_ignore`
- `vim.g.syntastic_go_checkers`

`<C-P>` now opens `Telescope find_files`, so the muscle memory carries over.

## Post-cut verification

Run after any change to this list. All of these passed at the time of the cut:

```sh
# matchit survives its plugin's removal
nvim --headless -c 'lua print(#vim.api.nvim_get_runtime_file("plugin/matchit.vim", true))' -c qa
# -> 2

# every cut language still has syntax
nvim --headless -c 'lua for _,l in ipairs{"ruby","markdown","less","scss","haml","erlang","javascript"} do
  print(l, #vim.api.nvim_get_runtime_file("syntax/"..l..".vim", false) > 0) end' -c qa
# -> all true

# the cut globals are gone and telescope loads
nvim --headless -c 'lua print(pcall(require,"telescope"), vim.g.ctrlp_map, vim.g.syntastic_go_checkers)' -c qa
# -> true nil nil
```

Treesitter highlighting cannot be confirmed with `inspect_pos` in headless mode — highlights are
computed on redraw and headless never redraws. Query the tree directly instead:

```sh
nvim --headless some.go -c 'lua
local b = vim.api.nvim_get_current_buf()
local tree = vim.treesitter.get_parser(b, "go"):parse()[1]
local q = vim.treesitter.query.get("go", "highlights")
local n = 0
for _ in q:iter_captures(tree:root(), b, 0, -1) do n = n + 1 end
print("captures:", n, "| parse errors:", tree:root():has_error())' -c qa
# -> captures: 9  | parse errors: false
```
