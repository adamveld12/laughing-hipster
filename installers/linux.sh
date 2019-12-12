#!/bin/bash


INSTALL_LIST='ctags dhex neofetch irssi man bison python2 iptables software-properties-common libncurses-dev uidmap gpg apt-transport-https tar zip unzip curl wget git ca-certificates build-essential make cmake gcc tmux apt-utils dnsutils python3 less libassuan-dev libc6-dev libdevmapper-dev libglib2.0-dev libgpgme-dev libgpg-error-dev libostree-dev libprotobuf-dev libprotobuf-c-dev libseccomp-dev libselinux1-dev libsystemd-dev pkg-config runc python-dev python3-dev ruby-dev lua5.1 libperl-dev';

X_INSTALL_LIST="snapd cairo libxcb terminator compton nitrogen i3 dunst xcb-proto xcb-util-image xcb-util-wm xcb-util-cursor xcb-util-xrm xcb-xk jsoncpp libcurl wireless_tools libmpdclient libx11-dev libxtst-dev" ;

echo "installing: ${INSTALL_LIST}";

SUDO="TRUE";

if [ "${UID}" = 0 ]; then
    SUDO=""
elif [ -z "$(which sudo)" ]; then
    echo "you must have sudo permissions or be root for this step";
    exit 1;
fi

sudo apt-get update;
sudo apt-get install -y ${INSTALL_LIST};
wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb;
sudo dpkg -i /tmp/packages-microsoft-prod.deb;
sudo apt-get update;
sudo apt-get install -y dotnet-sdk-3.0;

cd $HOME/Projects

if [ -z "$(which X)" ]; then 
    echo "no X server setup detected."
else
    sudo apt-get install -y  ${X_INSTALL_LIST};

    snap install code docker firefox thunderbird insomnia discord slack spotify;

    # install polybar and alacritty
fi

cd ${HOME}
