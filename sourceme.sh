#!/bin/sh

function files_debug_log() {
	if ! [[ -z "${FILES_DEBUG}" ]]; then
		echo -e "# [INFO] $@";
	fi
}

function load_plugins() {
	if [[ -d "${1}" ]]; then
		for plugin in ${1}/*; do
			if [[ -s $plugin ]]; then
				files_debug_log "loading $plugin";
				source $plugin;
			elif [[ -d $plugin ]] && [[ -f "$plugin/setup.sh" ]]; then
				files_debug_log "loading directory $plugin";
				source $plugin/setup.sh;
			fi
		done
	elif [[ -s "${1}" ]]; then
		source $1;
	fi
}

function reload_env() {
	files_debug_log "DEBUG MODE IS ENABLED. Turn if off via:\nunset FILES_DEBUG\n"

	export HOME=${1:-$PWD}

	files_debug_log "\$HOME='$HOME'";

	# load plugns
	load_plugins "$HOME/.files/plugins";


	if [[ -d "${HOME}/.bin" ]]; then
		PATH=${HOME}/.bin:${PATH};
	fi
}

reload_env
