#!/bin/sh

export FILES_TMUX_USER_CONFIG_DIR="${FILES_USER_CONFIG}/tmux";

tmux_setup_config() {
	[[ -d "${FILES_TMUX_USER_CONFIG_DIR}" ]] || mkdir -p "${FILES_TMUX_USER_CONFIG_DIR}";
	files_linkdir "${FILES_PLUGIN_ROOT}/config.d" "${FILES_TMUX_USER_CONFIG_DIR}" true;
}

tmux_setup_themepack(){
    local TMUX_THEMEPACK="${FILES_TMUX_USER_CONFIG_DIR}/.tmux-themepack";
    [[ -d "${TMUX_THEMEPACK}" ]] || git clone https://github.com/jimeh/tmux-themepack.git --branch 1.1.0 "${TMUX_THEMEPACK}";
}



if [[ -f "$(which tmux 2>&1)" ]]; then
	tmux_setup_config;
	tmux_setup_themepack;
fi
