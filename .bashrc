#!/bin/bash

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


if [ -d "${HOME}/tools/vim" ] ; then
    PATH=${HOME}/tools/vim:${PATH}
fi

if [ -d "${HOME}/.bin" ] ; then
    PATH=${HOME}/.bin:${PATH}
fi

# see environ manfile
export EDITOR=vim       # Default Editor
export VISUAL=$EDITOR   # Visual not really used differently from EDITOR anymore
export LESS='-iMR'      # Case insensite search, verbose prompting and raw output
export PAGER=less       # Used to display text / man files


#
# History
#
HISTCONTROL=ignoredups                    # No duplicate commands in history
HISTSIZE=50000                            # For a huge history
export HISTIGNORE="[   ]*:&:bg:fg:exit"   # Don't save these commands in the history
shopt -s histappend                       # Append to the history file, not overwrite

# source development settings
if [ -f ~/.dev_profile ]; then
      . ~/.dev_profile
fi

# if there is a C:/Projects folder on this box
# then I'm obviously using my work computer
if [ -d "C:/Projects" ]; then
  . ~/.work_profile
fi

# Load pretty colors
if [ -f ~/.shell_colors ]; then
    . ~/.shell_colors
fi

# Load any extra aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
