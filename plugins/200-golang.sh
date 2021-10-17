#!/bin/sh

export GVM_DIR="${HOME}/.gvm"

if [[ "${FILES_INSTALL_TOOLS}" = "true" ]] && ! [[ -d ${GVM_DIR} ]]; then
	# install go version manager
	echo "Installing go version manager";
	curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer -o /tmp/gvm-installer.sh;
	chmod +x /tmp/gvm-installer.sh && /tmp/gvm-installer.sh;
	source ~/.gvm/scripts/gvm;
	gvm install go1.17 -B;
	gvm use go1.17 --default;
fi

if [[ -s "${GVM_DIR}/scripts/gvm" ]]; then
	source ~/.gvm/scripts/gvm;
	[ -s "$GVM_DIR/scripts/bash_completion" ] && \. "$GVM_DIR/scripts/bash_completion";
fi

