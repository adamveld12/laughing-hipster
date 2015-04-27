#!/bin/bash

if [ -d "${HOME}/.bin" ] ; then
    PATH=${HOME}/.bin:${PATH}
fi


if [ -d "${HOME}/tools/vim" ] ; then
    PATH=${HOME}/Tools/vim:${PATH}
fi

# Load any extra aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# source development settings
if [ -f ~/.dev_profile ]; then
      . ~/.dev_profile
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
