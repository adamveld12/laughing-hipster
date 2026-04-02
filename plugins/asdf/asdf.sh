#!/bin/env bash

# Find where asdf should be installed
ASDF_TOOL_VERSIONS_FILENAME=".tool-versions";
ASDF_DATA_DIR="${HOME}/.asdf";
ASDF_CONFIG_FILE="${HOME}/.asdfrc";
ASDF_COMPLETIONS="${ASDF_DATA_DIR}/completions";


if [[ ! -f "$(which asdf)" ]]; then
    echo "[asdf] Installing asdf to ${ASDF_DATA_DIR}...";
    brew install asdf
fi

[[ -d "$ASDF_DATA_DIR/shims" ]] && PATH="${ASDF_DATA_DIR}/shims:${PATH}";
[[ -f "${ASDF_COMPLETIONS}/asdf.bash" ]] && . ${ASDF_COMPLETIONS}/asdf.bash;

alias asdf_ls='asdf plugin list all';
alias asdf_add='asdf plugin add';
alias asdf_ll='asdf list all';


# adds a plugin @ a version, installs and uses it
asdf_use() {
    local plugin=${1};
    local version=${2:-'latest'};


    if [[ -z "${plugin}" ]]; then
        echo "usage: asdf_use <plugin> [version]"
    fi

    asdf plugin add ${plugin};
    asdf install ${plugin} ${version};
    asdf local ${plugin} ${version};
}
