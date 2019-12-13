#!/bin/sh

if [ ! -d "${HOME}/.cargo" ]; then
	# install rust
	echo "installing rustup + rust stable";
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh;
	chmod +x /tmp/rustup.sh && /tmp/rustup.sh -y --no-modify-path;
	echo 'source $HOME/.cargo/env' > "${HOME}/.shell_extensions/rust.sh";
	source ${HOME}/.cargo/env
	rustup install stable;
fi