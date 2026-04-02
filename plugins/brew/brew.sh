#!/bin/env bash

LINUX_BREW_PATH="/home/linuxbrew/.linuxbrew";
MAC_BREW_PATH="/opt/homebrew/";

if  [[ ! -d "${LINUX_BREW_PATH}" && ! -d "${MAC_BREW_PATH}" ]]; then
	echo "Installing brew";
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew_install.sh;
	chmod +x /tmp/brew_install.sh;
	/tmp/brew_install.sh;
	rm -rf /tmp/brew_install.sh;
fi


if [[ -d "${MAC_BREW_PATH}" ]]; then
    HOMEBREW_PREFIX="${MAC_BREW_PATH}";
elif [[ -d "${LINUX_BREW_PATH}" ]]; then
    HOMEBREW_PREFIX="${LINUX_BREW_PATH}";
else
    echo "no brew detected"
    return -1;
fi

export HOMEBREW_PREFIX;

if [[ -f "${HOMEBREW_PREFIX}/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)";
    [[ -f "$(${HOMEBREW_PREFIX}/bin/brew --prefix bash-completion)/etc/bash_completion" ]] || ${HOMEBREW_PREFIX}/bin/brew install bash-completion;
    [[ -f "$(${HOMEBREW_PREFIX}/bin/brew --prefix bash-completion)/etc/bash_completion" ]] && source  "$(${HOMEBREW_PREFIX}/bin/brew --prefix bash-completion)/etc/bash_completion";
fi
