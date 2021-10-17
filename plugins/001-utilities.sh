#!/bin/sh

# symbolic links all files in a directory into the target
files_linkdir() {
	local SOURCE=$1;
	local DEST=$2;
	local FORCE=$3;

	if [[ -d "${SOURCE}" ]]; then

		if ! [[ -z "${FORCE}" ]] || ! [[ -d "${DEST}" ]]; then
			files_debug_log "LINKING $SOURCE -> $DEST"

			find "${SOURCE}" -type d | sed "s=${SOURCE}==" | xargs -I {} mkdir -p ${DEST}{};
			find "${SOURCE}" -type f | sed "s=${SOURCE}==" | xargs -I {} ln -fs ${SOURCE}{} ${DEST}{};
		fi
	fi
    # ln on windows pretty much only works with hardlinks it seems
    #ls -lA "${SOURCE}" | grep "^-" | awk '{print $9}' | xargs -I {} ln -vfs "${SOURCE}/{}" "${DEST}/{}"
}
