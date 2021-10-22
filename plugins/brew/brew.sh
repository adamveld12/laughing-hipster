#!/bin/env bash

export LINUX_BREW_PATH="/home/linuxbrew/.linuxbrew";

if ! [[ -d "${LINUX_BREW_PATH}" ]]; then
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew_install.sh;
	chmod +x /tmp/brew_install.sh;
	/tmp/brew_install.sh;
	rm -rf /tmp/brew_install.sh;
fi

[[ -f "${LINUX_BREW_PATH}/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)";


