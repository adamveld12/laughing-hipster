# presenting.vim

[sotte/presenting.vim](https://github.com/sotte/presenting.vim)

## What it does

Turns a Markdown (or org, or reStructuredText) file into a slideshow inside Neovim. Slides are
split on headings — no export step, no separate tool, the file stays a normal document.

## 80/20 usage

| Command / key | Does |
|---|---|
| `:PresentingStart` | start presenting the current buffer |
| `n` / `<Space>` | next slide |
| `p` | previous slide |
| `q` | quit the presentation |

Markdown splits on `#` headings by default. Set `g:presenting_top_margin` to push content down
the screen, and `g:presenting_font_large` for a figlet-rendered title slide.

## When to use

- **A technical walkthrough where the slides are mostly code.** The code stays real, syntax
  highlighted by your normal setup, with no copy-paste into a slide tool.
- **Talking through a design doc you already wrote in Markdown** — present it as-is rather than
  rebuilding it as slides.
- **Live-editing during a talk.** Fix a typo or change an example mid-presentation; it is still
  just a buffer.
