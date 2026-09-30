# guihua.lua

[ray-x/guihua.lua](https://github.com/ray-x/guihua.lua)

## What it does

A UI widget library — floating windows, list views, a text-based picker — used by `ray-x`'s
plugins to render their results. Like plenary, it is a dependency rather than something you
invoke.

## 80/20 usage

Installed solely for `go.nvim`, which uses it for:

- floating windows showing test output and coverage
- the picker for `:GoImpl` interface selection
- diagnostic and reference list views

There are no user-facing commands. It is declared in `plugins.lua` with the comment
`recommanded if need floating window support` — that is exactly its role.

Some of its widgets want a C build step for fuzzy matching; go.nvim's uses do not depend on it,
so no action is needed here.

## When to use

- **Keep it as long as `go.nvim` is installed.** Removing it degrades go.nvim's floating windows
  to plain messages.
- **Remove it together with `go.nvim`** if you ever drop Go support — nothing else here uses it.
