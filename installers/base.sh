#!/bin/bash
set -eou pipefail
shopt -s extglob

GO_VERSION=1.13
NODE_VERSION=12

linkDirectory() {
    SOURCE=$1;
    DEST=$2;
	echo "LINK $SOURCE -> $DEST"
	find ${SOURCE} -type d ! -name '.ssh' | sed "s=${SOURCE}==" | xargs -I {} mkdir -p ${DEST}{};
	find ${SOURCE} -type f ! -path "${SOURCE}/.ssh/config" | sed "s=${SOURCE}==" | xargs -I {} ln -vfs ${SOURCE}{} ${DEST}{};
    # ln on windows pretty much only works with hardlinks it seems
    #ls -lA "${SOURCE}" | grep "^-" | awk '{print $9}' | xargs -I {} ln -vfs "${SOURCE}/{}" "${DEST}/{}"
}

if [ -z "$1" ]; then
	echo "must define home directory";
fi


export HOME_DIR=/home/$1;
export USER_ARG=$1;
BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd );
SRC_DIR=${BASE_DIR}/src;
TOOLS_DIR=${BASE_DIR}/tools;
CONFIG_DIR=${SRC_DIR}/.config;
EXT_DIR=${SRC_DIR}/.shell_extensions;
export VIMRUNTIME=${HOME}/.config/vim/runtime;

if [ -d ${HOME_DIR} ]; then 
	echo "installing into ${HOME_DIR}";
else 
	echo "${HOME_DIR} doesn't exist";
	exit 1;
fi

export HOME=${HOME_DIR};

echo "installing dot files from ${BASE_DIR} into ${HOME_DIR}...";

mkdir -p ${HOME_DIR}/Projects;
mkdir -p ${HOME_DIR}/Downloads;
mkdir -p ${HOME_DIR}/Desktop;
mkdir -p ${HOME_DIR}/Documents/Pictures/Wallpapers;
mkdir -p ${HOME_DIR}/.ssh;

echo "linking dotfiles from ${SRC_DIR} to ${HOME_DIR}";
linkDirectory "${SRC_DIR}" "${HOME_DIR}";

echo "setting up ssh configuration";
# a check to see if they're using a config file and if it has a host setup
if [[ -f "${HOME_DIR}/.ssh/config" ]] && [[ -z $(cat "${HOME_DIR}/.ssh/config" | grep '[hH]ost \*') ]]; then
  echo "Appending ssh config";
  # we append it so we don't destroy any custom settings they may have
  cat "${BASE_DIR}/.ssh/config" >> "${HOME_DIR}/.ssh/config";
elif [ -f "${HOME_DIR}/.ssh/config" ]; then
  echo "Your SSHfu is strong, skipping config copy...";
else 
  echo "Copying new ssh config";
  mkdir -p "${HOME_DIR}/.ssh/";
  cp -n "${SRC_DIR}/.ssh/config" "${HOME_DIR}/.ssh/";
fi

if [ "$(uname)" = "Linux" ]; then
    source "${BASE_DIR}/installers/linux.sh";
	rm -rf ${HOME_DIR}/.shell_extensions/osx/;
elif [ "$(uname)" = "Darwin" ]; then
    echo "OSX not supported";
    source "${BASE_DIR}/installers/osx.sh";
	rm -rf ${HOME_DIR}/.shell_extensions/linux/;
else
    echo "windows is not supported";
fi


#------------------------------------------------------------------
#  Set up sub modules - link tools into home
#------------------------------------------------------------------

git submodule init && git submodule --progress update;

linkDirectory ${TOOLS_DIR} ${HOME_DIR}/tools;
#find ${BASE_DIR}/tools -type f | sed "s=${BASE_DIR}==" | xargs -I {} ln -fsv ${BASE_DIR}/{} ${HOME_DIR}/{}


#------------------------------------------------------------------
#  Set up home directory deps
#------------------------------------------------------------------
mkdir -p ${HOME_DIR}/.bin;

echo "setting up vim runtime folder @ ${VIMRUNTIME}";
mkdir -p ${VIMRUNTIME}/autoload ${VIMRUNTIME}/bundle && \
curl -LSso ${VIMRUNTIME}/autoload/pathogen.vim https://tpo.pe/pathogen.vim;


if [ ! -d "${HOME_DIR}/.gvm/" ]; then
	# install GVM
	echo "installing gvm";
	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer);
	echo "[[ -s \"\$HOME/.gvm/scripts/gvm\" ]] && source \"\$HOME/.gvm/scripts/gvm\"" > ${HOME_DIR}/.shell_extensions/gvm.sh;
	source ${HOME_DIR}/.gvm/scripts/gvm;
	gvm install go${GO_VERSION} -B;
    gvm use go${GO_VERSION} --default;
fi

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

if [ ! -d "${HOME}/.cargo" ]; then
	# install rust
	echo "installing rustup + rust stable";
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh;
	chmod +x /tmp/rustup.sh && /tmp/rustup.sh -y --no-modify-path;
	echo 'source $HOME/.cargo/env' > "${HOME}/.shell_extensions/rust.sh";
	source ${HOME}/.cargo/env
	rustup install stable;
fi

if [ ! -d "${HOME}/.rvm" ]; then
	gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://get.rvm.io | bash -s stable --ruby;
	echo "source \${HOME}/.rvm/scripts/rvm" > "${HOME}/.shell_extensions/rvm.sh"
	source ${HOME}/.rvm/scripts/rvm
fi

pushd ${HOME}/.config/vim/
rake
popd

find ${HOME} ! -path "${HOME}/Projects" ! -path "${HOME}" | xargs -I {} chown $@ {};
