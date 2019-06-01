#!/bin/bash
#vim: set ft=sh

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

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# runs vim outside of the term by forking the command and gvim, great for my windows box
function vd(){
  if [[ $# -eq 0 ]]; then
    gvim &
  else
    gvim --remote-tab-silent "$@" &
  fi
}


# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v(){
  if [[ $# -eq 0 ]]; then
    vim .;
  else
    vim --remote-tab-silent "$@";
  fi
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
	if [ $# -eq 0 ]; then
		subl .;
	else
		subl "$@";
	fi;
}

# delete merged local branches
function prunelocal(){
  for b in `git branch --merged | grep -v \*`; do git branch -D $b; done
}

# generates a public key from a private key
function pubkey(){
  if [[ -z $1 ]]; then
    echo "Takes a path to a private key and prints a compatible public key to stdout"
    echo "$1 required: path to a private key"
    return -1
  fi


  ssh-keygen -y -f $1
}
# list network interfaces
function interfaces(){
  ifconfig | grep "\: flags" | awk '{print $1}' | sed 's/:$//';
}

# Create a git.io short URL
function gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

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

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
}

# Simple calculator
function calc() {
	local result="";
	result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
	#                       └─ default (when `--mathlib` is used) is 20
	#
	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		printf "$result" |
		sed -e 's/^\./0./'        # add "0" for cases like ".5"` \
		    -e 's/^-\./-0./'      # add "0" for cases like "-.5"`\
		    -e 's/0*$//;s/\.$//';  # remove trailing zeros
	else
		printf "$result";
	fi;
	printf "\n";
}

# a shortcut for cloning from github
# usage: clone user/repo <dir>
function clone() {
  if [ -z "$1" ]; then
    echo "Missing git repository url ending"
    echo "usage: clone 'git repository ending' ['target directory name']"
  else
    giturl="git@github.com:$1.git"

    if [ -z "$2" ]; then
      # we DON'T HAVE a target directory
      git clone $giturl
    else
      # we HAVE a target directory
      git clone $giturl $2
    fi
  fi
}

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}
