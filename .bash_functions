#!/bin/bash
#vim: set ft=sh

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

# Get a character’s Unicode code point
function codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}


# simplifies using docker-compose
function dcm(){
  docker-compose $@
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
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

function diff-file() {
  if [[ -z $1 ]] || [[ -z $2 ]]; then
    echo "diff-file diffs two files (don't have to be in a repo)"
    echo "usage diff-file <file1> <file2>"
    return -1
  fi
  git diff --no-index --color --color-words "$@" | diff-so-fancy;
}

# UTF-8-encode a string of Unicode symbols
function escape() {
	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

# kill the process using the specified port
function freeport(){

  if [ -z $1 ]; then
    echo "usage: freeport <port number>" >&2
    return 1
  fi

  lsof -t -i tcp:$1 | xargs kill
}

# Compare original and gzipped file size
function gz() {
	local origsize=$(wc -c < "$1");
	local gzipsize=$(gzip -c "$1" | wc -c);
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
	printf "orig: %d bytes\n" "$origsize";
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo "ERROR: Certificate not found.";
		return 1;
	fi;
}

# Create a git.io short URL
function gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

function gocd(){
  if [ -z "$1" ]; then
    cd $GOPATH;
    return 0;
  fi

  cd $(go list -f '{{ .Dir }}' $1)
}

function interfaces(){
  ifconfig | grep "\: flags" | awk '{print $1}' | sed 's/:$//';
}

function inline_image {
  printf '\033]1338;url='"$1"';alt='"$2"'\a\n'
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript;
	else # pipe
		python -mjson.tool | pygmentize -l javascript;
	fi;
}



function pubkey(){
  if [[ -z $1 ]]; then
    echo "Takes a path to a private key and prints a compatible public key to stdout"
    echo "$1 required: path to a private key"
    return -1
  fi


  ssh-keygen -y -f $1
}

# delete merged local branches
function prunelocal(){
  for b in `git branch --merged | grep -v \*`; do git branch -D $b; done
}

function tunnel(){
  if [[ -z $1 ]]; then
      echo "Takes an ssh config host name and starts an SSH tunnel"
      echo "$1 required: name of an ssh tunnel host"
      echo "$2 optional: run the tunnel as a background job if defined"
      return -1
  fi

  if [[ -z $2 ]]; then
    sudo ssh -f -N $1
  else
    sudo ssh -f -N $1 &
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

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v(){
  if [[ $# -eq 0 ]]; then
    vim .;
  else
    vim --remote-tab-silent "$@";
  fi
}

# runs vim outside of the term by forking the command and gvim, great for my windows box
function vd(){
  if [[ $# -eq 0 ]]; then
    gvim &
  else
    gvim --remote-tab-silent "$@" &
  fi
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


# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
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

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}";
	local ip=$(ipconfig getifaddr en1);
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}


# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
