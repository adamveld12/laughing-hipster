#!/bin/sh

export RUSTUP_HOME="${HOME}/.config/rust/.rustup";
export CARGO_HOME="${HOME}/.config/rust/.cargo";
export PATH=${PATH}:${CARGO_HOME}/bin;

if ! [[ -d "${CARGO_HOME}" ]]; then
	# install rust
	echo "Installing rustup + rust stable";
	curl -sLSf https://sh.rustup.rs > /tmp/rustup.sh;
	chmod +x /tmp/rustup.sh && /tmp/rustup.sh -y --no-modify-path;
	source ${CARGO_HOME}/env
else
	source ${CARGO_HOME}/env
fi


