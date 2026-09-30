# AGENTS.md — `plugins/nvim/docs/`

Conventions for the Neovim plugin docs in this directory. Companion to the root `AGENTS.md`.

## Doc format

One file per plugin, named after the plugin without its `.nvim`/`.vim` suffix
(`fugitive.md`, `telescope.md`). Colorschemes are the one exception: all of them share
`colorschemes.md`, because per-theme docs are the same three lines fourteen times over.

Target 40–60 lines. These are references someone skims mid-task, not tutorials.

```markdown
# <plugin name>

[owner/repo](https://github.com/owner/repo)

Status: <only when there is something to flag — see below>

## What it does
Two or three sentences. What problem it solves, not a feature list.

## 80/20 usage
A table. The handful of commands that cover almost all real use, **plus this repo's own
bindings** from `config.d/init.lua` — a doc that lists stock defaults while the config
rebinds them is worse than no doc.

## When to use
Two or three concrete scenarios. "Resolving a merge conflict without leaving the buffer",
not "when you need Git integration".
```

Sections appear in that order, with those headings. The `Status:` line sits directly under the
GitHub link and is **omitted entirely** when there is nothing to flag.

Adding a plugin to `config.d/lua/plugins.lua` means adding its doc file and a `README.md` index
row in the same change.

## Superseded vs unmaintained

These are different findings and they get different treatment. The distinction is whether
something else already does the job, not whether upstream is alive.

| Verdict | Meaning | Action |
|---|---|---|
| **Superseded** | Neovim itself, or another installed plugin, already does this | **Remove it.** Add a `cut-list.md` row with the replacement and the evidence. Delete its config from `init.lua` in the same commit. |
| **Unmaintained** | Nothing replaces it; upstream is just dead | **Keep it.** `Status: UNMAINTAINED - <last activity>, <live fork if one exists>` |
| **Moved org** | Repo relocated, e.g. `scrooloose` → `preservim` | Update the spec to the live org. Mention the old name in the doc so searches still find it. |
| **Unconfigured** | Installed but never set up, so inert | Keep. `Status: UNCONFIGURED - <what is missing>` |

Unmaintained is not a reason to cut on its own. Several plugins here have been dead for years and
still do something nothing else does — `xmledit` and `vim-coloresque` both qualify. Age is not the
test; redundancy is.

## Evidence rule

A superseded claim gets **verified against the running Neovim before the plugin is cut**, never
inferred from the plugin's age or reputation. Record the check in `cut-list.md`.

```lua
-- is it already a builtin?
#vim.api.nvim_get_runtime_file('plugin/matchit.vim', true)   --> 2, so matchit.zip is redundant

-- does nvim already bundle this language's syntax?
vim.api.nvim_get_runtime_file('syntax/ruby.vim', false)
```

For vendored upstreams, read the header of Neovim's bundled file — `syntax/ruby.vim` names
`vim-ruby/vim-ruby` as its source and `syntax/markdown.vim` names `tpope/vim-markdown`. That is
proof the plugin *is* what Neovim already ships, not merely something similar.

After any cut, re-run the check to confirm the capability survived the removal.

## Branch and API rule

Read a plugin's API from the **installed copy** under
`~/.local/share/nvim/site/pack/packer/start/<plugin>/`, not from memory and not from the first web
result. Check `git rev-parse --abbrev-ref HEAD` there and read that branch's README.

`nvim-treesitter` is the cautionary case. It is installed on `main`, a full incompatible rewrite in
which `require('nvim-treesitter.configs').setup{}` does not exist — that call is `master`-branch
API, and most guides still show it. Writing it here produces a config that silently does nothing.

## Cuts are reversible

`cut-list.md` keeps each removal's original spec line verbatim, so undoing a cut is pasting one
line back into `plugins.lua`.
