#!/bin/sh

files_linkdir "${HOME}/.files/.config" "${HOME}/.config" true;

! [[ -f "${HOME}/.gitconfig" ]] && ln -svf "${HOME}/.config/git/.gitconfig" "${HOME}/.gitconfig";
