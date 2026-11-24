#!/bin/sh

files_debug_off() {
    unset FILES_DEBUG;
}

files_debug_on() {
    export FILES_DEBUG=true;
}

# debug logging
files_debug_log() {
	[[ -z "${FILES_DEBUG}" ]] || echo -e "# [FILES INFO] $@"
}

# symbolic links all files in a directory into the target
files_linkdir() {
	# Strip trailing slashes so REL always starts with "/" and callers can
	# pass either form (GNU find omits the doubled slash BSD find prints).
	local SOURCE="${1%/}";
	local DEST="${2%/}";
	local FORCE=$3;

	if [[ -d "${SOURCE}" ]]; then
		files_debug_log "LINKING $SOURCE -> $DEST"
		# One find per call; everything else is a bash builtin unless a
		# directory or link is actually missing or wrong. This runs on every
		# shell start, so each extra process adds noticeable startup time.
		local SRC_PATH REL TARGET;
		while IFS= read -r SRC_PATH; do
			REL="${SRC_PATH#"${SOURCE}"}";
			TARGET="${DEST}${REL}";
			if [[ -d "${SRC_PATH}" ]]; then
				[[ -d "${TARGET}" ]] || mkdir -p "${TARGET}";
			elif [[ "${TARGET}" -ef "${SRC_PATH}" ]]; then
				continue; # already linked
			elif [[ -n "${FORCE}" ]] || [[ ! -e "${TARGET}" ]]; then
				ln -fs "${SRC_PATH}" "${TARGET}";
			fi
		done < <(find "${SOURCE}" -type d -o -type f);
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

	export FILES_CACHE_DIR="${FILES_ROOT}/.tmp/";

	if [[ -d "${FILES_CACHE_DIR}" ]]; then
		files_debug_log "[load env] Setting up cache directory @ ${FILES_CACHE_DIR}";
		mkdir -p ${FILES_CACHE_DIR};
	fi

	if [[ -z "${FILES_PLUGINS}" ]]; then
		export FILES_PLUGINS=("brew" "ssh" "vim" "nvim" "git-extras" "asdf" "kubernetes" "starship" "extras");
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
