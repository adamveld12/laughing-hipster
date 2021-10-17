#!/bin/sh

export NVM_DIR="$HOME/.config/.nvm";

if [[ "${FILES_INSTALL_TOOLS}" = "true" ]] && ! [[ -d ${NVM_DIR} ]]; then
	# install node version manager
	echo "Installing node version manager";
	git clone --branch "${NVM_VERSION:-v0.39.0}" https://github.com/nvm-sh/nvm.git ${NVM_DIR};
	source ${NVM_DIR}/nvm.sh;
	nvm install ${NVM_VERSION:-v14};
	nvm alias default ${NVM_VERSION:-v14};
fi

if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
	source ${NVM_DIR}/nvm.sh;
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion";
fi



