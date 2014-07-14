# vim: set ft=sh
# https://github.com/smerrell/dotfiles
#


# downside of using MSYS
# LS_COLORS="di=01;36:"
# export LS_COLORS

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#
# Initialization
#
if [ -d "${HOME}/bin" ] ; then
    PATH=${HOME}/bin:${PATH}
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

#
# Prompt Customizations
#
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
GRAY="\[\033[1;30m\]"
EMPTY="\[\033[0;37m\]"

LIGHTBLUE="\[\033[38;5;111m\]"
LIGHTRED="\[\033[38;5;172m\]"
LIGHTYELLOW="\[\033[38;5;229m\]"
CONTINUE="\[\033[38;5;242m\]"
DARKGRAY="\[\033[38;5;247m\]"

# [hh:mm] username@host (git branch || svn revision) ~/working/directory
# $
# [hh:mm] username@host (git branch || svn revision) ~/working/directory
# $
# Pretty ugly hack for msys... need to figure out how to determine if my
# console is 256 color capable
if [ $OSTYPE = 'msys' ]; then
  PS1="$GREEN[\$(date +%H:%M)] \u@\h $RED $YELLOW\w \n$EMPTY\$ $GRAY"
  PS2="$CONTINUE> "
else
  PS1="$LIGHTBLUE[\$(date +%H:%M)] \u@\h $LIGHTRED $LIGHTYELLOW\w \n$EMPTY\$ $DARKGRAY"
  PS2="$CONTINUE> "
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

