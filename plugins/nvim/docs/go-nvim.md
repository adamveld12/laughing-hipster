# go.nvim

[ray-x/go.nvim](https://github.com/ray-x/go.nvim)

Status: **UNCONFIGURED** — `require('go').setup()` is never called, so none of the commands below
exist yet.

## What it does

A Go development layer over LSP and treesitter: test running, struct tag manipulation, interface
stub generation, `go.mod` management and debugging integration, wrapped in Neovim commands.

## 80/20 usage

Needs a setup call to register commands:

```lua
require('go').setup()
```

| Command | Does |
|---|---|
| `:GoTest` | test the current package |
| `:GoTestFunc` | test only the function under the cursor |
| `:GoTestFile` | tests in the current file |
| `:GoCoverage` | run coverage and show it in the sign column |
| `:GoFmt` / `:GoImport` | format / fix imports |
| `:GoIfErr` | generate the `if err != nil` block for the call above |
| `:GoFillStruct` | expand a struct literal with all its fields |
| `:GoAddTag json` | add struct tags to the struct under the cursor |
| `:GoImpl` | generate method stubs for an interface |
| `:GoAlt` | jump between a file and its `_test.go` |

## When to use

- **Tight test loops.** `:GoTestFunc` on the test under your cursor is far quicker than switching
  to a terminal and retyping a `-run` regex.
- **Boilerplate Go is famous for.** `:GoIfErr`, `:GoFillStruct` and `:GoAddTag` remove most of the
  typing that has no thought behind it.
- **Implementing an interface** — `:GoImpl` writes every stub with the right signatures.

Requires `guihua.lua` for floating windows (installed) and gopls via `nvim-lspconfig` for the
LSP-backed features.
