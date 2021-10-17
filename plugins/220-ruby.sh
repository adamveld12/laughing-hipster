#!/bin/sh

export RVM_HOME="${HOME}/.rvm";
if [[ "${FILES_INSTALL_TOOLS}" = "true" ]] && ! [[ -d "${RVM_HOME}" ]]; then
    command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -;
    command curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -;

	curl -sSL https://get.rvm.io | bash -s stable --ruby;
fi

if [[ -s ${RVM_HOME}/scripts/rvm ]]; then
    ! [[ -f ${HOME}/.rvmrc ]] && echo "rvm_silence_path_mismatch_check_flag=1" > ~/.rvmrc;
    source ${RVM_HOME}/scripts/rvm;
    [[ -s ${RVM_HOME}/scripts/completion ]] && source ${RVM_HOME}/scripts/completion | true;
    rvm use ruby-3.0.0 > /dev/null;
fi

