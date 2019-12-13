#!/bin/sh

GO_VERSION=1.13

if [ ! -d "${HOME_DIR}/.gvm/" ]; then
	# install GVM
	echo "installing gvm";
	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer);
	echo "[[ -s \"\$HOME/.gvm/scripts/gvm\" ]] && source \"\$HOME/.gvm/scripts/gvm\"" > ${HOME_DIR}/.shell_extensions/gvm.sh;
	source ${HOME_DIR}/.gvm/scripts/gvm;
	gvm install go${GO_VERSION} -B;
    gvm use go${GO_VERSION} --default;
fi