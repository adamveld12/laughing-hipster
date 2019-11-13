#!/bin/bash

# Bash behavior
shopt -s checkwinsize                       # Checks window size to get proper line wrapping
shopt -s cdspell                            # Corrects minor spelling errors when cd-ing
shopt -s checkjobs                          # Stops bash from exiting if there are jobs running. A second attempt at exiting will ignore.
set -o vi                                   # Set prompt to vi mode
set -o notify                               # Report status of terminated background jobs immediately
set -b                                      # report job status immediately

bind '"\C-l"':redraw-current-line # <Ctrl>-l
bind '"\e\C-l"':clear-screen      # <Escape>-<Ctrl>-l

set show-mode-in-prompt on                  # Shows vi mode status: + for vi insert mode, : for vi command mode
set print-completions-horizontally on       # Prints tab completions horizontally in alphabetical order
set colored-stats on                        # completions are printed colored based on their file type
set visible-stats on                        # completions are printed colored based on their file type

# History
export HISTCONTRO=Lignoreboth:erasedups                    # No duplicate commands in history
export HISTSIZE=-1
export HISTIGNORE="[   ]*:&:bg:fg:exit:clear"   # Don't save these commands in the history
shopt -s histappend                       # Append to the history file, not overwrite

# see environ manfile - just setting up my shell environment
export LESS='-iMR'      # Case insensite search, verbose prompting and raw output
export PAGER=less       # Used to display text / man files

export POWERLINE_CONFIG_COMMAND=~/tools/powerline/powerline/scripts/powerline-config
export GIT_EDITOR=vim
export EDITOR=$GIT_EDITOR
export VISUAL=$EDITOR
export VIMRUNTIME=${HOME}/.config/vim/runtime
export VIM=${HOME}/.config/vim

export WINDOWS=false

if [ -d "${HOME}/.bin" ] ; then
    PATH=${HOME}/.bin:${PATH}
fi

# give windows boxes a chance to override environment
if [ -d "/c/Windows" ]; then
  WINDOWS="TRUE"
  export GIT_EDITOR=~/tools/vim/gvim.exe

  if [ -f ~/.windows ]; then
    . ~/.windows
  fi
else
  export GOPATH=~/projects/go
  export DOTNETPATH=~/.dotnet/
fi


if [ -d "${HOME}/.config/vim" ] ; then
    PATH=${HOME}/.config/vim:${PATH}
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH=/usr/local/bin:${GOPATH}/bin:${GOROOT}/bin:${DOTNETPATH}:${HOME}/.bin:${PATH}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac



# http://stackoverflow.com/questions/410616/increasing-the-maximum-number-of-tcp-ip-connections-in-linux
# run these to increase concurrent connections in linux
# sudo sysctl net.ipv4.ip_local_port_range="18000 61000"
# sudo sysctl net.ipv4.tcp_fin_timeout="30"
# sudo sysctl net.ipv4.tcp_tw_recycle=1
# sudo sysctl net.ipv4.tcp_tw_reuse=1 
