#!/bin/sh

# kill the process using the specified port
function freeport(){

  if [ -z $1 ]; then
    echo "usage: freeport <port number>" >&2
    return 1
  fi

  lsof -t -i tcp:$1 | xargs kill
}

# runs tcp dump on the port specified in $1. $1 defaults to 8080
function dumptcp(){
  local DUMPPORT=$1
  local DUMPINTERFACE=$2

  if [ -z "$1" ]; then
    DUMPPORT=8080
  elif [[ "$1"  == "help" ]]; then
    echo "dumps tcp info at the specified port. Useful for looking at http requests"
    echo "usage dumptcp <port>"
    return 1
  fi

  if [ -z "$2" ]; then
    DUMPINTERFACE=lo0
  fi

  echo "dumping tcp connections @ $DUMPINTERFACE on port $DUMPPORT..."

  sudo tcpdump -s 0 -A -i $DUMPINTERFACE "tcp port $DUMPPORT and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)"
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* *;
	fi;
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
}


# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";
	echo "${tmpFile}.gz created successfully.";
}


# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool < "$*" | pygmentize -l javascript;
	else # pipe
		python -mjson.tool | pygmentize -l javascript;
	fi;
}

function interfaces(){
  ifconfig | grep "\: flags" | awk '{print $1}' | sed 's/:$//';
}

function inline_image {
  printf '\033]1338;url='"$1"';alt='"$2"'\a\n'
}

# Create a git.io short URL
function gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

# list files
alias ll='ls -hGla'

#git
alias gs='git status'
alias gm='git merge --ff-only'
alias gpr='git pull --rebase'
alias gmt='git mergetool'
alias grc='git rebase --continue'
alias gk='git fetch origin; git remote prune origin; gitk --all &'
alias gl='git log --pretty=format:"%h %ar by %an: %s"'
