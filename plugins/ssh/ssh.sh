#!/bin/env bash

export SSH_DIR="${HOME}/.ssh";

[[ -d "${SSH_DIR}" ]] || mkdir -p "${SSH_DIR}";

files_linkdir "${FILES_PLUGIN_ROOT}/defaults.d" "${SSH_DIR}";

ssh_setup_agent() {
	# Preserve a live forwarded agent on incoming SSH connections.
	if [[ -n "${SSH_CONNECTION}" && -S "${SSH_AUTH_SOCK}" ]]; then
		return 0;
	fi

	# Prefer 1Password's SSH agent socket when present (macOS Group Container, then ~/.1password).
	local op_sock;
	for op_sock in \
		"${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" \
		"${HOME}/.1password/agent.sock"; do
		if [[ -S "${op_sock}" ]]; then
			export SSH_AUTH_SOCK="${op_sock}";
			return 0;
		fi
	done

	command -v ssh-agent >/dev/null 2>&1 || return 0;

	# Reuse a single persistent agent socket so shells never leak ssh-agent processes.
	local fallback_sock="${SSH_DIR}/ssh-agent.sock";
	export SSH_AUTH_SOCK="${fallback_sock}";

	# ssh-add -l exits 0 (has keys) or 1 (running, empty); exit 2 means missing/dead socket.
	ssh-add -l >/dev/null 2>&1;
	if [[ $? -eq 2 ]]; then
		rm -f "${fallback_sock}";
		eval "$(ssh-agent -a "${fallback_sock}" -s)" >/dev/null 2>&1;
		if [[ "$(uname -s)" == "Darwin" ]]; then
			ssh-add --apple-load-keychain >/dev/null 2>&1;
		fi
	fi
}

ssh_setup_agent;


# Open an ssh tunnel
ssh_tunnel(){
  if [[ -z $1 ]]; then
      echo "Takes an ssh config host name and starts an SSH tunnel";
      echo "\$1 required: name of an ssh tunnel host";
      echo "\$2 optional: run the tunnel as a background job if defined";
      return -1;
  fi

  if [[ -z $2 ]]; then
    ssh -f -N $1;
  else
    ssh -f -N $1 &
  fi
}

# generate the public key for a private key
ssh_pubkey(){
  if [[ -z $1 ]]; then
    echo "Takes a path to a private key and prints a compatible public key to stdout";
    echo "$1 required: path to a private key";
    return -1;
  fi


  ssh-keygen -y -f $1;
}

# generate a new key
ssh_newkey() {
	local name=$1;
	local comment=$2;
	local quiet=$3;

	if [[ -z "${name}" ]]; then
		echo "ssh_newkey creates a new ssh key with the specified name and comment";
		echo "The new keys are saved in ${HOME}/.ssh/<name>/";
		echo "ssh_newkey <name> [comment]";
		exit 255;
	fi


	local algo='ed25519';
	local private_key_path="${HOME}/.ssh/${name}/id.${algo}";
	local public_key_path="${HOME}/.ssh/${name}/id.${algo}.pub";
	local gendate=$(date --rfc-3339=seconds);

	if [[ -d "${HOME}/.ssh/${name}" ]]; then
		exit 1;
	fi

	mkdir -p ${HOME}/.ssh/${name};

	ssh-keygen -t "${algo}" -C "$comment -- created ${gendate}" -f "${private_key_path}";

	echo -e "\n\n";
	echo -e "See your keys here: ${HOME}/.ssh/${name}";
	if [[ -z $(cat "${HOME}/.ssh/config" | grep "Host ${name}") ]]; then
		echo "Updating ssh config @ ${HOME}/.ssh/config. Edit to your liking.";
		cat <<-	EOF >> ${HOME}/.ssh/config

		Host ${name}
				IdentityFile ${private_key_path}
				UserKnownHostsFile ${HOME}/.ssh/${name}/known_hosts
		EOF
	fi
}
