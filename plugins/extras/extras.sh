#!/bin/env bash

if [[ -z "${FILES_EXTRAS_DIR}" ]]; then
	export FILES_EXTRAS_DIR="${HOME}/.files-extras";
fi


if ! [[ -d "${FILES_EXTRAS_DIR}" ]]; then
	mkdir -p "${FILES_EXTRAS_DIR}";
	files_linkdir "${FILES_PLUGIN_ROOT}/default.d/" "${FILES_EXTRAS_DIR}/";
fi

for file in "${FILES_EXTRAS_DIR}"/*; do
	[[ -f "${file}" ]] && source "${file}";
done;
