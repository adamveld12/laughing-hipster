#!/bin/sh

export NVM_DIR="$HOME/.config/.nvm"

if ! [[ -d ${NVM_DIR} ]]; then
	# install node version manager
	echo "Installing node version manager";
	git clone https://github.com/nvm-sh/nvm.git ${NVM_DIR}
	git checkout "${NVM_VERSION:-v0.39.0}"
	source ${NVM_DIR}/nvm.sh;
	nvm install ${NVM_VERSION:-v14};
	nvm alias default ${NVM_VERSION:-v14};
else
	source ${NVM_DIR}/nvm.sh;
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion";



