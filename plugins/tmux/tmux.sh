#!/bin/sh


if [[ -f "$(which tmux 2>&1)" ]]; then
    export TMUX_CONFIG_FILE="${FILES_USER_CONFIG}/tmux.conf";

    if ! [[ -f "${TMUX_CONFIG_FILE}"  ]]; then
        files_debug_log "linking";
        files_linkdir "${FILES_PLUGIN_ROOT}/config.d/" "${FILES_USER_CONFIG}/tmux";
    fi

    export TMUX_THEMEPACK="${FILES_USER_CONFIG}/tmux/.tmux-themepack";
    if ! [[ -d "${TMUX_THEMEPACK}" ]]; then
        git clone https://github.com/jimeh/tmux-themepack.git --branch 1.1.0 "${TMUX_THEMEPACK}";
    fi
fi
