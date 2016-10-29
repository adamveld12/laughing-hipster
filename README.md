laughing-hipster
================

My dot files

## What's included?

A very simplistic plugin system, drop shell scripts you would like to source into the ~/.extensions directory. .profile will load them automatically.

A custom SSH config setup with nice defaults.

Installs Brew when run on OSX, along with several utilities I commonly use.

Comes with an uninstall script.

Themes for vim, iterm2 and for cmder when ran on windows.

Tmux and vim configurations

## Install

1. cd into `~`
3. run `laughing-hipster/bootstrap.sh`

The installer backs up your current home folder dotfiles into `.home_bkup` and then symlinks in the dotfiles for this repo. The installer also preserves your ssh config if you have customized it already.

Because everything is symlinked, all you have to do for most updates is just `git pull`.

## Uninstall
 
1. cd into `~`
2. run `./laughing-hipster/remove.sh`


The uninstaller will leave the ssh config in place and copy all of the files from `.home_bkup` into their original places. It will also remove the tools folder and any dot files that have the same name as the ones in this repo. 

Basically you end up back where you started (or close to) without anything destructive happening.

## Extending with custom scripts

This set up will source all files found in a `~/.extensions/` directory or in a file named `~/.extensions` at the last moment. This allows you to extend and customize how everything works to your liking.

