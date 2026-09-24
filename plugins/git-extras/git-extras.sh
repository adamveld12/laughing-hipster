#!/bin/env bash

export GIT_EXTRAS_DIR="${FILES_USER_CONFIG}/git";

GIT_EXTRAS_CONFIG="${FILES_PLUGIN_ROOT}/gitconfig";
GIT_EXTRAS_LOCAL_CONFIG="${GIT_EXTRAS_DIR}/local";
GIT_GLOBAL_CONFIG="${HOME}/.gitconfig";
GIT_LEGACY_CONFIG="${FILES_PLUGIN_ROOT}/defaults.d/.gitconfig";
GIT_LEGACY_XDG_CONFIG="${GIT_EXTRAS_DIR}/.gitconfig";

[[ -d "${GIT_EXTRAS_DIR}" ]] || mkdir -p "${GIT_EXTRAS_DIR}";
files_linkdir "${FILES_PLUGIN_ROOT}/defaults.d" "${GIT_EXTRAS_DIR}" true;

if [[ -L "${GIT_LEGACY_XDG_CONFIG}" ]] && [[ "$(readlink "${GIT_LEGACY_XDG_CONFIG}")" == "${GIT_LEGACY_CONFIG}" ]]; then
    rm "${GIT_LEGACY_XDG_CONFIG}";
fi

GIT_EXTRAS_INSTALL_CONFIG=true;
if [[ -e "${GIT_GLOBAL_CONFIG}" || -L "${GIT_GLOBAL_CONFIG}" ]]; then
    GIT_GLOBAL_CONFIG_TARGET="";
    if [[ -L "${GIT_GLOBAL_CONFIG}" ]]; then
        GIT_GLOBAL_CONFIG_TARGET="$(readlink "${GIT_GLOBAL_CONFIG}")";
    fi

    if [[ "${GIT_GLOBAL_CONFIG_TARGET}" != "${GIT_EXTRAS_CONFIG}" && "${GIT_GLOBAL_CONFIG_TARGET}" != "${GIT_LEGACY_CONFIG}" ]]; then
        if [[ -e "${GIT_EXTRAS_LOCAL_CONFIG}" || -L "${GIT_EXTRAS_LOCAL_CONFIG}" ]]; then
            GIT_EXTRAS_INSTALL_CONFIG=false;
        elif [[ -L "${GIT_GLOBAL_CONFIG}" ]]; then
            files_debug_log "[git-extras] preserving ${GIT_GLOBAL_CONFIG} as ${GIT_EXTRAS_LOCAL_CONFIG}";
            if ! cp -L "${GIT_GLOBAL_CONFIG}" "${GIT_EXTRAS_LOCAL_CONFIG}" || ! rm "${GIT_GLOBAL_CONFIG}"; then
                echo "[git-extras] Failed to preserve ${GIT_GLOBAL_CONFIG}" >&2;
                GIT_EXTRAS_INSTALL_CONFIG=false;
            fi
        else
            files_debug_log "[git-extras] moving ${GIT_GLOBAL_CONFIG} to ${GIT_EXTRAS_LOCAL_CONFIG}";
            if ! mv "${GIT_GLOBAL_CONFIG}" "${GIT_EXTRAS_LOCAL_CONFIG}"; then
                echo "[git-extras] Failed to preserve ${GIT_GLOBAL_CONFIG}" >&2;
                GIT_EXTRAS_INSTALL_CONFIG=false;
            fi
        fi
    fi
fi

if [[ "${GIT_EXTRAS_INSTALL_CONFIG}" == true ]]; then
    ln -sfn "${GIT_EXTRAS_CONFIG}" "${GIT_GLOBAL_CONFIG}";
fi

unset GIT_EXTRAS_CONFIG GIT_EXTRAS_LOCAL_CONFIG GIT_GLOBAL_CONFIG GIT_LEGACY_CONFIG;
unset GIT_LEGACY_XDG_CONFIG GIT_EXTRAS_INSTALL_CONFIG GIT_GLOBAL_CONFIG_TARGET;

alias gs='git status';
alias gp='git pull';
alias gm='git merge --ff-only';
alias gpr='git pull --rebase';
alias gmt='git mergetool';
alias grc='git rebase --continue';
alias gk='git fetch origin; git remote prune origin; gitk --all &';
alias gl='git log --pretty=format:"%h %ar by %an: %s"';
