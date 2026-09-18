#!/bin/env bash

export FILES_NVIM_USER_CONFIG_DIR="${FILES_USER_CONFIG}/nvim";

nvim_setup_config() {
    [[ -d "${FILES_NVIM_USER_CONFIG_DIR}" ]] || mkdir -p "${FILES_NVIM_USER_CONFIG_DIR}";
    files_linkdir "${FILES_PLUGIN_ROOT}/config.d" "${FILES_NVIM_USER_CONFIG_DIR}" true;
}

# nvim-treesitter (main branch) builds parsers with tree-sitter-cli and a C
# compiler. Must be the brew formula, not the npm package -- they are different
# artifacts and nvim-treesitter only supports the former.
nvim_setup_treesitter_cli() {
    command -v tree-sitter >/dev/null 2>&1 && return 0;
    command -v brew >/dev/null 2>&1 || return 0;

    files_debug_log "[nvim] installing tree-sitter-cli for nvim-treesitter";
    brew install tree-sitter-cli;
}

[[ -d "${FILES_USER_CONFIG}/nvim" ]] || nvim_setup_config

if command -v nvim >/dev/null 2>&1; then
    nvim_setup_treesitter_cli;
fi
