#!/bin/sh

if [[ -d "${HOME}/.config/vim" ]]; then
	export VIM=${HOME}/.config/vim;
	export VIMRUNTIME=${VIM}/runtime;
    # export PATH=${VIM}:${PATH};

	files_linkdir "/usr/share/vim/vim82/" "${VIMRUNTIME}/";

	! [[ -f ${HOME}/.vimrc ]] && ln -sf ${VIM}/.vimrc ${HOME}/.vimrc;

	if ! [[ -f "${VIMRUNTIME}/autoload/pathogen.vim" ]]; then
		files_debug_log "installing pathogen.vim";
		if ! [[ -d "/tmp/vim-pathogen/" ]]; then
			git clone git://github.com/tpope/vim-pathogen.git /tmp/vim-pathogen;
			if [[ -d "/tmp/vim-pathogen/autoload" ]]; then
				mkdir -p ${VIMRUNTIME}/autoload/;
				cp -r /tmp/vim-pathogen/autoload/* ${VIMRUNTIME}/autoload/;
			fi
		fi

	fi

	if ! [[ -d "${VIMRUNTIME}/bundle" ]]; then
		files_debug_log "installing vim plugins...";
		pushd ${VIM};
		[[ -f "$(which rake)" ]] && rake;
		popd;
	fi

fi

