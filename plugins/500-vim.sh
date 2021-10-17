#!/bin/sh

export VIM="${HOME}/.config/vim";
export VIMRUNTIME="${VIM}/runtime";
export VIM_BUNDLE="${VIM}/runtime/bundle"

if [[ -d ${VIM} ]]; then

	install_vim_plugins() {
		[[ -d ${VIM_BUNDLE} ]] && rm -rf ${VIM_BUNDLE};
		mkdir -p ${VIM_BUNDLE};

		pushd ${VIM_BUNDLE}
		local PLUGINS=$(cat ${VIM}/plugins.txt);
		for plugin in ${PLUGINS}; do
			if [[ "${plugin:0:3}" = "git" ]]; then
				echo "Installing $plugin...";
				git clone -q $plugin > /dev/null &
			fi
		done
		time wait;
		popd;
	}

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
		install_vim_plugins
	fi

fi

