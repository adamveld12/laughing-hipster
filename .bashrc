# vim: set ft=sh
# https://github.com/smerrell/dotfiles
#

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#
# Initialization
#
if [ -d "${HOME}/bin" ] ; then
    PATH=${HOME}/bin:${PATH}
fi

if [ -d "${HOME}/tools/vim" ] ; then
    PATH=${HOME}/tools/vim:${PATH}
fi

if [ -d "${HOME}/.bin" ] ; then
    PATH=${HOME}/.bin:${PATH}
fi

#
# Dircolors
#
#if [ -f ~/.dircolors ]; then
 # eval `dircolors -b ~/.dircolors`
#fi

# see environ manfile
export EDITOR=vim       # Default Editor
export VISUAL=$EDITOR   # Visual not really used differently from EDITOR anymore
export LESS='-iMR'      # Case insensite search, verbose prompting and raw output
export PAGER=less       # Used to display text / man files
export PORT=3001


#
# History
#
HISTCONTROL=ignoredups                    # No duplicate commands in history
HISTSIZE=50000                            # For a huge history
export HISTIGNORE="[   ]*:&:bg:fg:exit"   # Don't save these commands in the history
shopt -s histappend                       # Append to the history file, not overwrite

#
# Bash behavior
#
shopt -s checkwinsize   # Checks window size to get proper line wrapping
shopt -s cdspell        # Corrects minor spelling errors when cd-ing
set -o vi               # Set prompt to vi mode
set -o notify           # Report status of terminated background jobs immediately

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

function vim(){
  if [[ $# -eq 0 ]]; then
    gvim &
  else
    gvim --remote-tab-silent "$@" &
  fi
}
