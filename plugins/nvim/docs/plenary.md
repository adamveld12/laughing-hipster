# plenary.nvim

[nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## What it does

A standard library for Lua plugins: async primitives, path manipulation, job control, a test
harness, curl bindings. Almost nothing here is meant to be called by you directly — it exists so
other plugins do not each reimplement it.

## 80/20 usage

Installed as a **dependency**, not for direct use. In this config it is required by:

- `telescope.nvim` (declared as its `requires`)
- `go.nvim`

If you write Lua for your own config, the pieces worth knowing:

| Module | Does |
|---|---|
| `plenary.path` | path joining, existence, read/write, without string mangling |
| `plenary.job` | run an external process async with stdout/stderr callbacks |
| `plenary.async` | coroutine-based async/await |
| `plenary.test_harness` | `:PlenaryBustedFile %` to run busted-style specs |

## When to use

- **Never remove it** while telescope or go.nvim are installed — both break immediately.
- **Writing your own config Lua** that shells out: `plenary.job` is much less error-prone than
  `vim.fn.system` for anything async.
- **Testing config Lua** — `plenary.test_harness` is the de-facto standard for Neovim plugin
  tests.
