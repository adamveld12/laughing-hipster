# Files

My dotfiles repo.

- Vim setup
- Git settings
- Simple "plugin" system (drop files into `~/.files-plugins` and they are sourced)
- Custom prompt
- Ruby enVironment Manager, Rustup, Go Version Manager, Node Version Manager
- Some terminal defaults I like
- Utility functions


## Installation

1. Clone into your home directory at `~/.files`
2. Add `[[ -s ~/.files/sourceme.sh ]] && source ~/.files/sourceme.sh` to your `.bashrc`, `.bash_profile` etc.


## Development

Run `make build dev` to drop into a container with everything pre installed.


## LICENSE

MIT
