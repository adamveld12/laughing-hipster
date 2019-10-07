#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# source environment settings
if [ -f ~/.environment ]; then
     . ~/.environment
fi

# for when you want to do custom junk
# Sources a folder with shell extensions
if [ -d ~/.shell_extensions ]; then
  for plugin in ~/.shell_extensions/*; do
    if [ -f $plugin ]; then
      source $plugin
    fi
  done
fi

if [ -f "./.motd" ]; then
    source .motd
fi
