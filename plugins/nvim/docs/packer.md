# packer.nvim

[wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)

Status: **ARCHIVED** upstream in August 2023. Still works, but receives no fixes.
[lazy.nvim](https://github.com/folke/lazy.nvim) is the successor the ecosystem moved to.

## What it does

The plugin manager. Clones each plugin declared in `config.d/lua/plugins.lua` into Neovim's
package directory, and removes anything installed that is no longer declared.

## 80/20 usage

| Command | Does |
|---|---|
| `:PackerSync` | the one you want — install new, update existing, remove undeclared |
| `:PackerInstall` | install missing only |
| `:PackerClean` | remove undeclared only |
| `:PackerStatus` | what is installed and at what commit |
| `:PackerCompile` | regenerate the compiled loader |

`init.lua` recompiles automatically on write via a `BufWritePost plugins.lua` autocmd, so editing
the plugin list then running `:PackerSync` is the whole workflow.

Packer bootstraps itself. `ensure_packer()` in `plugins.lua` clones it on a fresh machine,
because `packadd packer.nvim` fails with `E919` otherwise.

## Gotcha worth knowing

Packer is declared `opt = true` so its spec matches the `pack/packer/opt/` location that
`ensure_packer()` clones into. Declare it without `opt` and packer's clean step deletes the
bootstrap clone as undeclared — and it reinstalls on **every** launch.

## When to use

- **Adding or removing a plugin**: edit `plugins.lua`, `:PackerSync`, done.
- **A plugin behaving strangely after an update**: `:PackerStatus` to see the commit, then
  pin it with `commit = '<sha>'` in its spec.
- **Migrating to lazy.nvim**, eventually. Not urgent — nothing is broken — but this is the one
  plugin here with no maintainer and no drop-in fix if Neovim changes under it.
