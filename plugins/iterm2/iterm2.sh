#!/bin/env bash
# from https://github.com/mbadolato/iTerm2-Color-Schemes

export FILES_ITERM2_USER_CONFIG_DIR="${FILES_USER_CONFIG}/iterm2/themes";

iterm2_setup_config() {
    [[ -d "${FILES_ITERM2_USER_CONFIG_DIR}" ]] || mkdir -p "${FILES_ITERM2_USER_CONFIG_DIR}";
    files_linkdir "${FILES_PLUGIN_ROOT}/config.d/themes" "${FILES_ITERM2_USER_CONFIG_DIR}" true;
}

[[ -d "${FILES_USER_CONFIG}/iterm2/themese" ]] || iterm2_setup_config
