# xmledit

[sukima/xmledit](https://github.com/sukima/xmledit)

Status: **UNMAINTAINED** — effectively dormant for years. Kept because nothing built into Neovim
replaces it; see `AGENTS.md`, *Superseded vs unmaintained*.

## What it does

Tag-aware editing for XML and HTML: closes tags as you type, keeps a tag and its closing partner
in sync when you rename one, and wraps selections in a new tag. Neovim bundles XML *syntax*, but
no tag-editing behaviour — which is why this survived the cut.

## 80/20 usage

| Trigger | Does |
|---|---|
| `>` after typing `<tag` | inserts the matching `</tag>` and puts the cursor between them |
| `>` twice | same, but splits across three lines with the cursor indented in the middle |
| `<Leader>x` (visual) | wrap the selection in a tag it prompts for |
| `<Leader>5` / `%` | jump between the opening and closing tag |
| `<Leader>d` | delete the surrounding tag pair, keeping the contents |

Editing the name of an opening tag renames its partner automatically while
`g:xmledit_enable_html` is on for HTML buffers.

Note `<Leader>` here is `,` in this config, so the wrap binding is `,x` — **which collides with
this config's `,x` strip-trailing-whitespace mapping**. The plugin's binding loses. Remap via
`g:xml_tag_completion_map` if you want it.

## When to use

- **Hand-editing XML config** — Maven poms, Android manifests, build files — where tag balance is
  the main source of mistakes.
- **HTML without a full web setup**, when you want tag closing but not an LSP and a formatter.
- **Restructuring nested markup**, where `,d` unwraps a layer without hunting for its closing tag.

For heavy web work, treesitter plus an HTML language server is the better answer.
