laughing-hipster
================

My dot files

## Install

1. Clone this into ~
2. cd into laughing-hipster
3. run `./bootstrap.sh`

The installer preserves your ssh config and everything in the .ssh folder. 

## Uninstall
 
1. cd into laughing-hipster
2. run `./remove.sh`


The uninstaller will leave the ssh config in place and copy all of the files from `.home_bkup` into their original places. It will also remove the tools folder and any dot files that have the same name as the ones in this repo. 

Basically you end up back where you started (or close to) without anything destructive happening.
