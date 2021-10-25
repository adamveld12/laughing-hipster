#!/bin/sh

# debug logging
files_debug_log() {
	if ! [[ -z "${FILES_DEBUG}" ]]; then
		echo -e "# [INFO] $@";
	fi
}

# symbolic links all files in a directory into the target
files_linkdir() {
	local SOURCE=$1;
	local DEST=$2;
	local FORCE=$3;

	if [[ -d "${SOURCE}" ]]; then
		if ! [[ -z "${FORCE}" ]] || ! [[ -d "${DEST}" ]]; then
			files_debug_log "LINKING $SOURCE -> $DEST"
			mkdir -p ${DEST};
			find "${SOURCE}" -type d | sed "s=${SOURCE}==" | xargs -I {} mkdir -p ${DEST}{};
			find "${SOURCE}" -type f | sed "s=${SOURCE}==" | xargs -I {} ln -fs ${SOURCE}{} ${DEST}{};
		fi
	fi
    # ln on windows pretty much only works with hardlinks it seems
    #ls -lA "${SOURCE}" | grep "^-" | awk '{print $9}' | xargs -I {} ln -vfs "${SOURCE}/{}" "${DEST}/{}"
}

files_plugins_list() {
	for plugin in ${FILES_PLUGINS[@]}; do
		export FILES_PLUGIN_ROOT="${FILES_ROOT}/plugins/${plugin}";
		echo "\"${plugin}\" @ ${FILES_PLUGIN_ROOT}";
		unset FILES_PLUGIN_ROOT;
	done
}

files_install() {
	local target=${1};
	local FILES_SOURCEME=$(cat ${FILES_ROOT}/install_script.sh);

	if [[ -f "${target}" ]]; then
		if [[ -z "$(cat ${target} | grep 'sourceme.sh')" ]]; then
			files_debug_log "[files_install] installing myself to $target";
			echo "${FILES_SOURCEME}" >> ${target};
		fi
	fi
}

load_env() {
	files_debug_log "[load_env] DEBUG MODE IS ENABLED. Turn if off via:\nunset FILES_DEBUG\n";
	if [[ -d "${1}" ]]; then
		export HOME=${1};
	fi

	if [[ -z "${FILES_ROOT}" ]]; then
		export FILES_ROOT="${HOME}/.files";
	fi

	files_debug_log "[load_env] \$FILES_ROOT = ${FILES_ROOT}";
	export FILES_USER_CONFIG="${HOME}/.config";

	if [[ -z "${FILES_PLUGINS}" ]]; then
		export FILES_PLUGINS=("brew" "ssh" "vim" "git-extras" "asdf" "helm" "starship" "extras");
	fi
	files_debug_log "[load_env] using plugins FILES_PLUGINS=${FILES_PLUGINS}";

	files_debug_log "[load_env] \$HOME='$HOME'";
	# load plugns
	for plugin in ${FILES_PLUGINS[@]}; do
       set +b;
		export FILES_PLUGIN_ROOT="${FILES_ROOT}/plugins/${plugin}";
		if [[ -f "${FILES_PLUGIN_ROOT}/${plugin}.sh" ]]; then
			files_debug_log "[PLUGIN] LOADING ${plugin} @ ${FILES_PLUGIN_ROOT}";
			source "${FILES_PLUGIN_ROOT}/${plugin}.sh";
		fi
		unset FILES_PLUGIN_ROOT;
        set -b;
	done

	files_debug_log "[load_env] setting up ${FILES_USER_CONFIG} directory";
	files_linkdir "${FILES_ROOT}/.config" ${FILES_USER_CONFIG};

	[[ -f "${HOME}/.bashrc" ]] && files_install "${HOME}/.bashrc";
	[[ -f "${HOME}/.bash_profile" ]] && files_install "${HOME}/.bash_profile";
	[[ -f "${HOME}/.profile" ]] && files_install "${HOME}/.profile";

	return 0;
}

load_env || true;
