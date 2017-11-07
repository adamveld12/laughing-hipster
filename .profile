#!/bin/bash


# source environment settings
if [ -f ~/.environment ]; then
      . ~/.environment
fi

# Load any extra aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Load pretty colors
if [ -f ~/.shell_colors ]; then
    . ~/.shell_colors
fi


# for when you want to do custom junk
# Sources a folder with shell extensions
if [ -d ~/.extensions ]; then
  for plugin in ~/.extensions/*; do
    source $plugin
  done
fi
