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

# enable programmable completion features
if [ -f /etc/git_completion ]; then
    . /etc/git_completion
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# for when you want to do custom junk
if [ -f ~/.extensions ]; then
  . ~/.extensions
# Sources a folder with shell extensions
elif [ -d ~/.extensions ]; then
  echo "sourcing plugins"
  for plugin in ~/.extensions/; do
    echo $plugin
  done
fi

printmotd
