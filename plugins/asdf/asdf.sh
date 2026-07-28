#!/bin/env bash

# Find where asdf and its data should be installed
ASDF_VERSION="${ASDF_VERSION:-"0.20.0"}";
ASDF_DATA_DIR="${ASDF_DATA_DIR:-${ASDF_DIR:-$HOME/.asdf}}";
ASDF_BIN_DIR="${ASDF_BIN_DIR:-$HOME/.local/bin}";
ASDF_BIN="${ASDF_BIN_DIR}/asdf";

export ASDF_DATA_DIR;

case ":${PATH}:" in
    *":${ASDF_BIN_DIR}:"*) ;;
    *) export PATH="${ASDF_BIN_DIR}:${PATH}" ;;
esac

case ":${PATH}:" in
    *":${ASDF_DATA_DIR}/shims:"*) ;;
    *) export PATH="${ASDF_DATA_DIR}/shims:${PATH}" ;;
esac

asdf_install() {
    local os;
    local arch;
    local release_version="${ASDF_VERSION#v}";
    local archive;
    local url;
    local temp_dir;
    local dependency;

    case "$(uname -s)" in
        Darwin) os="darwin" ;;
        Linux) os="linux" ;;
        *)
            echo "[asdf] Unsupported operating system: $(uname -s)" >&2;
            return 1;
            ;;
    esac

    case "$(uname -m)" in
        x86_64|amd64) arch="amd64" ;;
        arm64|aarch64) arch="arm64" ;;
        i386|i486|i586|i686)
            if [[ "${os}" != "linux" ]]; then
                echo "[asdf] Unsupported architecture for ${os}: $(uname -m)" >&2;
                return 1;
            fi
            arch="386";
            ;;
        *)
            echo "[asdf] Unsupported architecture: $(uname -m)" >&2;
            return 1;
            ;;
    esac

    for dependency in curl tar install mktemp; do
        if ! command -v "${dependency}" >/dev/null 2>&1; then
            echo "[asdf] Required command not found: ${dependency}" >&2;
            return 1;
        fi
    done

    archive="asdf-v${release_version}-${os}-${arch}.tar.gz";
    url="https://github.com/asdf-vm/asdf/releases/download/v${release_version}/${archive}";
    temp_dir="$(mktemp -d)" || return 1;

    echo "[asdf] Installing asdf v${release_version} to ${ASDF_BIN}...";

    if ! curl -fsSL "${url}" -o "${temp_dir}/${archive}"; then
        echo "[asdf] Failed to download ${url}" >&2;
        rm -rf "${temp_dir}";
        return 1;
    fi

    if ! tar -xzf "${temp_dir}/${archive}" -C "${temp_dir}" || [[ ! -f "${temp_dir}/asdf" ]]; then
        echo "[asdf] Failed to extract ${archive}" >&2;
        rm -rf "${temp_dir}";
        return 1;
    fi

    if ! mkdir -p "${ASDF_BIN_DIR}" "${ASDF_DATA_DIR}" || ! install -m 0755 "${temp_dir}/asdf" "${ASDF_BIN}"; then
        echo "[asdf] Failed to install asdf to ${ASDF_BIN}" >&2;
        rm -rf "${temp_dir}";
        return 1;
    fi

    rm -rf "${temp_dir}";
}

if [[ ! -x "${ASDF_BIN}" ]]; then
    asdf_install;
fi
unset -f asdf_install;

if command -v asdf >/dev/null 2>&1; then
    . <(asdf completion bash)
fi

# Ensures a tool has an installed home default without checking for upgrades.
asdf_ensure_tool() {
    local tool="${1:-}";
    local requested_version="${2:-latest}";
    local plugin_url="${3:-}";
    local tool_versions_file="${HOME}/${ASDF_TOOL_VERSIONS_FILENAME:-.tool-versions}";
    local home_version="";
    local resolved_version="${requested_version}";

    if [[ -z "${tool}" ]]; then
        echo "usage: asdf_ensure_tool <tool> [version] [plugin-url]" >&2;
        return 1;
    fi

    if ! command -v asdf >/dev/null 2>&1; then
        echo "[asdf] asdf is not available; cannot install ${tool}" >&2;
        return 1;
    fi

    if ! asdf plugin list | grep -Fxq "${tool}"; then
        echo "[asdf] Adding ${tool} plugin...";
        if [[ -n "${plugin_url}" ]]; then
            asdf plugin add "${tool}" "${plugin_url}" || return 1;
        else
            asdf plugin add "${tool}" || return 1;
        fi
    fi

    if [[ -f "${tool_versions_file}" ]]; then
        home_version="$(awk -v tool="${tool}" '$1 == tool { print $2; exit }' "${tool_versions_file}")";
    fi

    if [[ "${requested_version}" == "latest" ]]; then
        if [[ -n "${home_version}" ]] && asdf where "${tool}" "${home_version}" >/dev/null 2>&1; then
            return 0;
        fi

        if ! resolved_version="$(asdf latest "${tool}")" || [[ -z "${resolved_version}" ]]; then
            echo "[asdf] Unable to resolve the latest ${tool} version" >&2;
            return 1;
        fi
    elif [[ "${home_version}" == "${requested_version}" ]] && asdf where "${tool}" "${requested_version}" >/dev/null 2>&1; then
        return 0;
    fi

    if ! asdf where "${tool}" "${resolved_version}" >/dev/null 2>&1; then
        echo "[asdf] Installing ${tool} ${resolved_version}...";
        asdf install "${tool}" "${resolved_version}" || return 1;
    fi

    asdf set --home "${tool}" "${resolved_version}" || return 1;
}

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
    asdf set ${plugin} ${version};
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
