#!/bin/sh

export RUSTUP_HOME="${HOME}/.config/rust/.rustup";
export CARGO_HOME="${HOME}/.config/rust/.cargo";
export PATH=${PATH}:${CARGO_HOME}/bin;

if [[ "${FILES_INSTALL_TOOLS}" = "true" ]] && ! [[ -d ${CARGO_HOME} ]]; then
	# install rust
	echo "Installing rustup + rust stable";
	curl -sLSf https://sh.rustup.rs > /tmp/rustup.sh;
	chmod +x /tmp/rustup.sh && /tmp/rustup.sh -y --no-modify-path;
fi

[[ -s "${CARGO_HOME}/env" ]] && source ${CARGO_HOME}/env;


