#!/bin/env bash

export GIT_EXTRAS_DIR="${FILES_USER_CONFIG}/git";

[[ -d "${GIT_EXTRAS_DIR}" ]] || mkdir -p "${GIT_EXTRAS_DIR}";
[[ -f "${HOME}/.gitconfig" ]] || ln -sf "${FILES_PLUGIN_ROOT}/defaults.d/.gitconfig" "${HOME}/.gitconfig";

files_linkdir "${FILES_PLUGIN_ROOT}/defaults.d" "${GIT_EXTRAS_DIR}" true;

alias gs='git status';
alias gm='git merge --ff-only';
alias gpr='git pull --rebase';
alias gmt='git mergetool';
alias grc='git rebase --continue';
alias gk='git fetch origin; git remote prune origin; gitk --all &';
alias gl='git log --pretty=format:"%h %ar by %an: %s"';
