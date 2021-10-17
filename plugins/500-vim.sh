#!/bin/sh

if [[ -d "${HOME}/.config/vim" ]]; then
	export VIM=${HOME}/.config/vim;
	export VIMRUNTIME=${VIM}/runtime;
    # export PATH=${VIM}:${PATH};

	files_linkdir "/usr/share/vim/vim82/" "${VIMRUNTIME}";

	! [[ -f ${HOME}/.vimrc ]] && ln -s ${VIM}/.vimrc ${HOME}/.vimrc;

	if ! [[ -f "${VIMRUNTIME}/autoload/pathogen.vim" ]]; then
		! [[ -d "/tmp/vim-pathogen" ]] && git clone git://github.com/tpope/vim-pathogen.git /tmp/vim-pathogen;
		mkdir -p ${VIMRUNTIME}/autoload/;
		cp -r /tmp/vim-pathogen/autoload/* ${VIMRUNTIME}/autoload;
	fi

	if ! [[ -d "${VIMRUNTIME}/bundle" ]]; then
		pushd ${VIM}
		rake
		popd
	fi
fi

