#!/bin/bash

# source development settings
if [ -f ~/.dev_profile ]; then
      . ~/.dev_profile
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

if [ -d ~/.nvm ]; then
  . ~/.nvm/nvm.sh
fi

printmotd

if [[  ${WINDOWS} == "TRUE" ]]; then
  b2dinitW
else
  b2dinit
fi
