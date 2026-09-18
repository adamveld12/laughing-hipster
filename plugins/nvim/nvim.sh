#!/bin/env bash

export FILES_NVIM_USER_CONFIG_DIR="${FILES_USER_CONFIG}/nvim";

nvim_setup_config() {
    [[ -d "${FILES_NVIM_USER_CONFIG_DIR}" ]] || mkdir -p "${FILES_NVIM_USER_CONFIG_DIR}";
    files_linkdir "${FILES_PLUGIN_ROOT}/config.d" "${FILES_NVIM_USER_CONFIG_DIR}" true;
}

[[ -d "${FILES_USER_CONFIG}/nvim" ]] || nvim_setup_config
