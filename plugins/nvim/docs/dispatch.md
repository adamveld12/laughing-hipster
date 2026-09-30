# vim-dispatch

[tpope/vim-dispatch](https://github.com/tpope/vim-dispatch)

## What it does

Runs builds and test suites asynchronously and routes the output into the quickfix list, so
compiler errors become a navigable list instead of a wall of terminal text. Editing stays
responsive while the job runs.

## 80/20 usage

| Command | Does |
|---|---|
| `:Make` | async `:make`, results into quickfix |
| `:Dispatch <cmd>` | run any command async, parse into quickfix |
| `:Dispatch!` | run in the background, do not focus the results |
| `:Start <cmd>` | long-running process (a dev server) in its own window |
| `:Copen` | open the quickfix list with the last run's output |
| `:cn` / `:cp` | jump to next / previous error |

`:Dispatch` with no argument uses `b:dispatch`, which you can set per filetype —
`let b:dispatch = 'go test ./...'`.

## When to use

- **Running a test suite without freezing the editor.** `:Dispatch go test ./...`, keep working,
  then `:Copen` and jump straight to each failure.
- **Compile-fix loops.** `:Make`, then `:cn` through the errors, each one landing on the exact line.
- **Starting a dev server** with `:Start npm run dev` so it lives in its own window rather than
  blocking Neovim.
