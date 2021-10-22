#!/bin/env bash

if ! [[ -f "$(which starship)" ]] && [[ -f "$(which brew)" ]]; then
	brew install starship;
fi

if [[ -f "$(which starship)" ]]; then
	export STARSHIP_CONFIG_DIR="${FILES_USER_CONFIG}/starship";
	export STARSHIP_CACHE="${STARSHIP_CONFIG_DIR}/cache";

	files_debug_log "[starship] installing default config";
	files_linkdir "${FILES_PLUGIN_ROOT}/defaults.d/" "${STARSHIP_CONFIG_DIR}/";

	starship_run() {
		local shell=${1:-bash};
		eval "$(starship init ${1})";
	}

	starship_install() {
		local target=${1};
		local shell=${2:-bash};

		if [[ -f "${target}" ]] && [[ -z "$(cat ${target} | grep 'starship_run')" ]]; then
			echo "starship_run ${shell}" >> ${target};
		fi
	}

	[[ -f "${HOME}/.bashrc" ]] && starship_install "${HOME}/.bashrc";
	[[ -f "${HOME}/.bash_profile" ]] && starship_install "${HOME}/.bash_profile";
	[[ -f "${HOME}/.profile" ]] && starship_install "${HOME}/.profile";
fi
