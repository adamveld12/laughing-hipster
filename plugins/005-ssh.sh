#!/bin/sh
mkdir -p ${HOME}/.ssh/;
# handy functions

# Open an ssh tunnel
ssh_tunnel(){
  if [[ -z $1 ]]; then
      echo "Takes an ssh config host name and starts an SSH tunnel"
      echo "\$1 required: name of an ssh tunnel host"
      echo "\$2 optional: run the tunnel as a background job if defined"
      return -1
  fi

  if [[ -z $2 ]]; then
    ssh -f -N $1
  else
    ssh -f -N $1 &
  fi
}

# generate the public key for a private key
function ssh_pubkey(){
  if [[ -z $1 ]]; then
    echo "Takes a path to a private key and prints a compatible public key to stdout"
    echo "$1 required: path to a private key"
    return -1
  fi


  ssh-keygen -y -f $1
}

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

ssh_newconfig() {
	cat <<-	EOF > ${HOME}/.ssh/config
	Host *
		    # verbosity used when logging messages from ssh, QUIET, FATAL, ERROR, INFO, VERBOSE, DEBUG, DEBUG1, DEBUG2, DEBUG3
		    LogLevel INFO
		    # if YES, never auto add host keyes and refuses to connecto to hosts that have changed. YES, NO, ASK
		    StrictHostKeyChecking ask
		    # known hosts file database location
		    UserKnownHostsFile ~/.ssh/known_hosts
		    # timeout in seconds after which if no data has been recieved from the server, ssh will send a keep alive message
		    ServerAliveInterval 30
		    # the number of times to send a keep alive message in a row, only applies to ssh v2
		    ServerAliveCountMax 120
		    # Shows the ssh key image on connection. YES or NO
		    VisualHostKey yes
		    # if the connection should use compression. YES or NO
		    Compression yes
		    # allows ssh to prefer one method of auth over another if there are multiple methods available. gssapi-with-mic, hostbased, publickey, keyboard-interactive, password
		    PreferredAuthentications publickey,password,keyboard-interactive
		    # send TCP keep alive messages to the host, which lets us know if the connection dies, but it can give false negatives (if the connection goes down temporarily, you'll get disconnected). YES, NO
		    TCPKeepAlive yes
		    # refer to: https://github.com/FiloSottile/whosthere/blob/master/README.md
		    PubkeyAuthentication yes
		    IdentitiesOnly yes
	EOF

}

if ! [[ -f ${HOME}/.ssh/config ]]; then
	ssh_newconfig
fi
