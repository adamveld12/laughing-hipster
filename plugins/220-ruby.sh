#!/bin/sh

export RVM_HOME="${HOME}/.rvm"

if ! [[ -d "${RVM_HOME}" ]]; then
    command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -;
    command curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -;

	curl -sSL https://get.rvm.io | bash -s stable --ruby;
	source ${RVM_HOME}/scripts/rvm;
	rvm use ruby-3.0.0;
	source ${RVM_HOME}/scripts/completion;
else
	echo "rvm_silence_path_mismatch_check_flag=1" > ~/.rvmrc;
	source ${RVM_HOME}/scripts/rvm;
	rvm use ruby-3.0.0 > /dev/null;
	source ${RVM_HOME}/scripts/completion;
fi

