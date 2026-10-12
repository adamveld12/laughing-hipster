# Keymaps

This repo's own bindings from `config.d/init.lua`. Leader is `,`. Plugin-specific bindings are
also listed in each plugin's doc ([telescope](telescope.md), [nerdtree](nerdtree.md)).

## Windows (splits)

| Key | Action |
|---|---|
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | move to the split left / down / up / right |
| `Ctrl-Shift-h` / `Ctrl-Shift-l` | width −4 / +4 |
| `Ctrl-Shift-k` / `Ctrl-Shift-j` | height +4 / −4 |
| `Ctrl-a` / `Ctrl-d` (or with Shift) | width +4 / −4 |
| `Ctrl-x` / `Ctrl-w` (or with Shift) | height +4 / −4 |
| `Ctrl-Shift-Right` / `Ctrl-Shift-Left` | width +5 / −5 |
| `Ctrl-Shift-Up` / `Ctrl-Shift-Down` | height +5 / −5 |
| `qo` | close every other split (`:only`) |

`Ctrl-Shift-<letter>` needs CSI-u key reporting: in iTerm2, Settings → Profiles → Keys →
"Report keys using CSI u"; tmux is set up for it in `tmux.conf` (`extended-keys`).

Conflicts to know about:
- `Ctrl-a` is the tmux prefix, so inside tmux it reaches nvim only as `Ctrl-a Ctrl-a`.
- `Ctrl-w` replaces vim's `<C-w>` window-command prefix; use `:wincmd` instead.
- `Ctrl-d`, `Ctrl-a`, `Ctrl-x` replace half-page down and number increment/decrement.

## Files and buffers

| Key | Action |
|---|---|
| `,ww` | write |
| `,W` | write as root (`sudo tee`) |
| `qq` / `QQ` | quit / quit without saving |
| `,w` | list buffers |
| `,v` | open `init.lua` in a new tab |
| `,rr` | reload `init.lua` |
| `,cp` | copy the current file path to the clipboard |
| `,c` | generate ctags into `.git/tags` |
| `,e` | open the location list (errors) |

## Editing

| Key | Action |
|---|---|
| `Space` / `\` | clear search highlight |
| `Ctrl-/` | toggle comment (normal, visual, insert) |
| `,x` | strip trailing whitespace |
| `,k` | delete every space in the file (`:%s/ //g`) |
| `,j` / `,J` | join lines / join without adding spaces |
| `Shift-u` | half-page up |
| `>` / `<` (visual) | indent and keep the selection |
| `Shift-j` / `Shift-k` (visual) | move the selection down / up |
| `;;` (visual) | leave visual mode |
| `p` (visual) | paste over the selection without overwriting the register |
| `Tab` / `Shift-Tab` (insert) | next / previous completion item |
| `F1` | disabled |
