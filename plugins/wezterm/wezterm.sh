#!/bin/sh

WEZTERM_VERSION=""
WEZTERM_INSTALL_DIR="${HOME}/bin"


if [[ -f "$(which wezterm 2>&1)" ]]; then
    export WEZTERM_CONFIG_FILE="${FILES_USER_CONFIG}/wezterm/wezterm.lua";

    if ! [[ -f "${WEZTERM_CONFIG_FILE}" ]]; then
        files_debug_log "linking"
        files_linkdir "${FILES_PLUGIN_ROOT}/defaults.d/" "${FILES_USER_CONFIG}/wezterm";
    fi
fi
