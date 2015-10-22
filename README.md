laughing-hipster
================

My dot files

## Install

1. Clone this into ~
2. cd into laughing-hipster
3. run `./bootstrap.sh`

The installer backs up your current home folder dotfiles into `.home_bkup` and then symlinks in the dotfiles for this repo. The installer also preserves your ssh config if you have customized it already.

Because everything is symlinked, all you have to do for most updates is just `git pull`.

## Extending with custom scripts

This set up will source all files found in a `~/.extensions/` directory or in a file named `~/.extensions` at the last moment. This allows you to extend and customize how everything works to your liking.

## Uninstall
 
1. cd into laughing-hipster
2. run `./remove.sh`


The uninstaller will leave the ssh config in place and copy all of the files from `.home_bkup` into their original places. It will also remove the tools folder and any dot files that have the same name as the ones in this repo. 

Basically you end up back where you started (or close to) without anything destructive happening.
