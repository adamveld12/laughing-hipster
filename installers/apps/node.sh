#!/bin/sh

NODE_VERSION=12

if [ ! -d "${HOME}/.nvm" ]; then
	# install nvm
	echo "installing nvm";
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash;
	echo "export NVM_DIR=\"\$HOME/.nvm\"" > "${HOME}/.shell_extensions/nvm.sh";
	echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "${HOME}/.shell_extensions/nvm.sh";
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> "${HOME}/.shell_extensions/nvm.sh";
	NVM_DIR=${HOME}/.nvm;
	source $NVM_DIR/nvm.sh;

	nvm install v${NODE_VERSION};
fi
