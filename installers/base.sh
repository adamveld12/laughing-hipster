#!/bin/bash
set -eou pipefail
shopt -s extglob


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

if [ -d ${HOME_DIR} ]; then 
	echo "installing into ${HOME_DIR}";
else 
	echo "${HOME_DIR} doesn't exist";
	exit 1;
fi

export HOME=${HOME_DIR};

echo "installing dot files from ${BASE_DIR} into ${HOME_DIR}...";

mkdir -p ${HOME_DIR}/projects;
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

if [ -f "${BASE_DIR}/tools" ]; then
    git submodule init && git submodule --progress update;
    linkDirectory ${TOOLS_DIR} ${HOME_DIR}/tools;
else
    echo "skipping tools..."
fi

#------------------------------------------------------------------
#  Set up home directory deps
#------------------------------------------------------------------
mkdir -p ${HOME_DIR}/.bin;

source ${BASE_DIR}/apps/golang.sh;
source ${BASE_DIR}/apps/node.sh;
source ${BASE_DIR}/apps/rust.sh;
source ${BASE_DIR}/apps/rvm.sh;

find ${HOME} ! -path "${HOME}/projects" ! -path "${HOME}" | xargs -I {} chown $@ {};
