Dotfiles
================

![GitHub](https://img.shields.io/github/license/adamveld12/laughing-hipster)
![Platform](https://img.shields.io/badge/platform-Debian%2C%20Ubuntu%2C%20OSX-lightgrey)

My dot files

## What's included?

A very simplistic plugin system, drop shell scripts you would like to source into the `~/.shell_extensions` directory and they get automatically loaded.

A custom SSH config setup with nice defaults.

Comes with an uninstall script.

Themes for vim, iterm2 and for cmder when ran on windows.

Tmux and vim configurations.

i3 (sway if using wayland), compton, polybar, dunst, nitrogen for linux window management.

## Install

1. Run `./install <username>` and everything is automatically installed:
    - symlinks `.vimrc`, `.tmux.conf`, `.gitconfig`, `.motd`, `.profile`, `.shell_extensions`, `.config`, `.ssh/config` to home directory
    - backups existing copies of all files to `.dotfiles_backup_<date>/`
    - installs rvm, gvm, nvm, rustup
    - compton, dunst, nitrogen, polybar if x is detected


## Extending with custom scripts

This set up will source all files found in a `~/.shell_extensions/` directory. This allows you to extend and customize how everything works to your liking.


## LICENSE

MIT
