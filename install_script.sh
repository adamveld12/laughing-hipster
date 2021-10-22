#!/bin/env bash

# where the .files repo lives. By default it's assumed to be in ${HOME}/.files
export FILES_ROOT="${HOME}/.files";

# Set plugins to load here. Run files_plugins_list to see available plugins.
export FILES_PLUGINS=("brew" "ssh" "vim" "git-extras" "asdf" "helm" "starship" "extras");

[[ -s "${HOME}/.files/sourceme.sh" ]] && source ${HOME}/.files/sourceme.sh;
