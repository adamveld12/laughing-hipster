#!/bin/sh

files_linkdir "${HOME}/.files/.config" "${HOME}/.config" true;

! [[ -f "${HOME}/.gitconfig" ]] && ln -s "${HOME}/.config/git/.gitconfig" "${HOME}/.gitconfig";
