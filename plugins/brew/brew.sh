#!/bin/env bash

export LINUX_BREW_PATH="/home/linuxbrew/.linuxbrew";
export MAC_BREW_PATH="/usr/local/Homebrew";
export APPLE_SILICON_BREW_PATH="/opt/homebrew";

if ! command -v brew >/dev/null 2>&1 \
    && [[ ! -x "${LINUX_BREW_PATH}/bin/brew" ]] \
    && [[ ! -x "${MAC_BREW_PATH}/bin/brew" ]] \
    && [[ ! -x "${APPLE_SILICON_BREW_PATH}/bin/brew" ]]; then
	echo "Installing brew";
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew_install.sh;
	chmod +x /tmp/brew_install.sh;
	/tmp/brew_install.sh;
	rm -rf /tmp/brew_install.sh;
fi

[[ -x "${LINUX_BREW_PATH}/bin/brew" ]] && eval "$(${LINUX_BREW_PATH}/bin/brew shellenv)";
[[ -x "${MAC_BREW_PATH}/bin/brew" ]] && eval "$(${MAC_BREW_PATH}/bin/brew shellenv)";
[[ -x "${APPLE_SILICON_BREW_PATH}/bin/brew" ]] && eval "$(${APPLE_SILICON_BREW_PATH}/bin/brew shellenv)";

if command -v brew >/dev/null 2>&1; then
    [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] || brew install bash-completion@2;
    [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
fi
