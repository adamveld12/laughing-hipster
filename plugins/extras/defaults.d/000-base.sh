#!/bin/sh

shopt -s checkwinsize;                       # Checks window size to get proper line wrapping
shopt -s cdspell;                            # Corrects minor spelling errors when cd-ing
shopt -s checkjobs;                          # Stops bash from exiting if there are jobs running. A second attempt at exiting will ignore.
set -o vi;                                   # Set prompt to vi mode
set -o notify;                               # Report status of terminated background jobs immediately
set -b;                                      # report job status immediately
set show-mode-in-prompt on;                  # Shows vi mode status: + for vi insert mode, : for vi command mode
set print-completions-horizontally on;       # Prints tab completions horizontally in alphabetical order
set visible-stats on;                        # completions are printed colored based on their file type
set colored-stats on;                        # completions are printed colored based on their file type

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# History
# https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps
shopt -s histappend;                       # Append to the history file, not overwrite
export HISTCONTROL="ignoreboth:erasedups";                    # No duplicate commands in history
export HISTSIZE=25000;
export HISTFILESIZE=10000;
export HISTIGNORE="[   ]*:&:bg:fg:exit:clear";   # Don't save these commands in the history
export HISTORY_COMMAND="history -a; history -c; history -r;"; # flush each command to history immediately
stty -ixon;

# see environ manfile - just setting up my shell environment
export LESS='-iMR';      # Case insensite search, verbose prompting and raw output
export PAGER=less;       # Used to display text / man files

export GPG_TTY=$(tty);

export GIT_EDITOR=vim;
export EDITOR=$GIT_EDITOR;
export VISUAL=$EDITOR;

if [[ -d "${HOME}/.bin" ]]; then
	PATH=${HOME}/.bin:${PATH};
fi

# bindings
bind '"\C-l"':redraw-current-line; # <Ctrl>-l
bind '"\e\C-l"':clear-screen;      # <Escape>-<Ctrl>-l

# http://stackoverflow.com/questions/410616/increasing-the-maximum-number-of-tcp-ip-connections-in-linux
# run these to increase concurrent connections in linux
# sudo sysctl net.ipv4.ip_local_port_range="18000 61000"
# sudo sysctl net.ipv4.tcp_fin_timeout="30"
# sudo sysctl net.ipv4.tcp_tw_recycle=1
# sudo sysctl net.ipv4.tcp_tw_reuse=1
