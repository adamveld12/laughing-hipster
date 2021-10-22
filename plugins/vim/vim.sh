#!/bin/env bash

if [[ -d "${FILES_USER_CONFIG}/vim" ]]; then
	export VIM="${FILES_USER_CONFIG}/vim";
	export VIMRUNTIME="${VIM}/runtime";
	export VIM_BUNDLE="${VIM}/runtime/bundle";
	export VIM_SOURCE="${VIM}/.source";

	vim_install_plugins() {
		local PATHOGEN_TMP="${VIM_SOURCE}/vim-pathogen";
		if ! [[ -f "${VIMRUNTIME}/autoload/pathogen.vim" ]]; then
			files_debug_log "[vim_install_plugins] installing pathogen.vim";
			if ! [[ -d "${PATHOGEN_TMP}" ]]; then
				git clone git://github.com/tpope/vim-pathogen.git ${PATHOGEN_TMP};
			fi

			mkdir -p ${VIMRUNTIME}/autoload/;
			cp -r ${PATHOGEN_TMP}/autoload/* ${VIMRUNTIME}/autoload/;
		fi


		[[ -d ${VIM_BUNDLE} ]] && return 0;
		files_debug_log "installing vim plugins...";

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

	vim_setup_runtime() {
		[[ -d ${VIMRUNTIME} ]] && return 0;
		files_debug_log "installing vim runtime files...";
		! [[ -d "${VIM_SOURCE}" ]] && git clone https://github.com/vim/vim.git --branch "${VIM_VERSION:-v8.2.3551}" "${VIM_SOURCE}/vim";
		files_linkdir "${VIM_SOURCE}/vim/runtime/" "${VIMRUNTIME}/";
	}

	vim_setup_config() {
		[[ -d ${VIM} ]] && return 0;
		files_debug_log "installing vim config files...";
		files_linkdir "${FILES_PLUGIN_ROOT}/config.d/" ${VIM};
	}

	vim_setup() {
		! [[ -f ${HOME}/.vimrc ]] && ln -sf ${VIM}/.vimrc ${HOME}/.vimrc;
        mkdir -p ${VIM}/backups;
        mkdir -p ${VIM}/swaps;
        mkdir -p ${VIM}/undo;

		vim_setup_config;
		vim_setup_runtime;
		vim_install_plugins;
	}

	vim_resetup() {
		[[ -d ${VIMRUNTIME} ]] && rm -rf ${VIMRUNTIME};

		vim_setup;
	}

	vim_setup;
fi


