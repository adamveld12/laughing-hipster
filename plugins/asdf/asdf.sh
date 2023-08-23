#!/bin/env bash

# Find where asdf should be installed
ASDF_VERSION="${ASDF_VERSION:-"0.8.1"}";
ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}";
ASDF_COMPLETIONS="$ASDF_DIR/completions";


if [[ ! -f "$ASDF_DIR/asdf.sh" ]]; then
    echo "[asdf] Installing asdf to ${ASDF_DIR}...";
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v${ASDF_VERSION};
fi

[[ -f "$ASDF_DIR/asdf.sh" ]] && . "$ASDF_DIR/asdf.sh"
[[ -f "${ASDF_COMPLETIONS}/asdf.bash" ]] && . ${ASDF_COMPLETIONS}/asdf.bash;

alias asdf_list_all='asdf plugin list all';
alias asdf_add='asdf plugin add';
alias asdf_list_versions='asdf list all';


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

asdf_local_use() {
    local TOOL_VERSIONS_PATH='.tool-versions';
    if [ -z "${1}" ]; then
        TOOL_VERSIONS_PATH="${1}";
    fi

    cat ${TOOL_VERSIONS_PATH}  | xargs -I {} asdf local {};
}

asdf_add_plugins() {
    local TOOL_VERSIONS_PATH='.tool-versions';
    if [ -z "${1}" ]; then
        TOOL_VERSIONS_PATH="${1}";
    fi

    awk '{print $1}' ${TOOL_VERSIONS_PATH}  | xargs -I {} asdf plugin add {};
}
