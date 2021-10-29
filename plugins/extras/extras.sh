#!/bin/env bash

if [[ -z "${FILES_EXTRAS_DIR}" ]]; then
	export FILES_EXTRAS_DIR="${HOME}/.files-extras";
fi


if ! [[ -d "${FILES_EXTRAS_DIR}" ]]; then
	files_debug_log "[extras] installing default files"
	files_linkdir "${FILES_PLUGIN_ROOT}/defaults.d/" "${FILES_EXTRAS_DIR}/";
fi

for file in "${FILES_EXTRAS_DIR}"/*; do
	[[ -f "${file}" ]] && source "${file}";
done;