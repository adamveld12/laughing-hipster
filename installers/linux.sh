#!/bin/bash

ALACRITTY_VERSION=0.3.3;

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
    curl -L https://github.com/jwilm/alacritty/releases/download/v${ALACRITTY_VERSION}/Alacritty-v${ALACRITTY_VERSION}-ubuntu_18_04_amd64.deb  > /tmp/alacritty.deb;
    sudo apt install -y /tmp/alacritty.deb;

    # install polybar
    git clone --branch 3.4.0 --recursive https://github.com/polybar/polybar polybar
    cd ./polybar
    cd build
    cmake ..
    make -j$(nproc)
    sudo make install
    cd ..

    snap install code docker firefox thunderbird insomnia discord slack spotify;
fi

# install vim with all of the necessary features
[ ! -s "${HOME}/Projects/vim" ] && git clone --branch v8.1.2109 https://github.com/vim/vim vim
cd ./vim

VIM_CONFIG_ARGS='
  --enable-multibyte \
  --enable-rubyinterp=yes \
  --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu \
  --enable-python3interp=yes \
  --enable-perlinterp=yes \
  --enable-luainterp=yes \
  --disable-netbeans \
  --with-compiledby="Adam V <adam@veldhousen.net>" \
  --enable-gui=auto \
  --enable-cscope \
  --prefix=/usr/local
'

VIM_CONFIG_X_ARGS='
  --enable-gtk2-check \
  --enable-gnome-check \
  --with-x 
'
if [ ! -z "$(which X)" ]; then
    echo "adding X options"
    VIM_CONFIG_ARGS="${VOM_CONFIG_ARGS} ${VIM_CONFIG_X_ARGS}"
fi

./configure ${VIM_CONFIG_ARGS}

make VIMRUNTUMEDIR=${HOME}/.config/vim/runtime/
sudo make install VIMRUNTIMEDIR=${HOME}/.config/vim/runtime/


VIMFILES=/usr/local/share/vim/vim81
find ${VIMFILES} -type f |  \
   sed "s=${VIMFILES}==" | \
   xargs -I {} dirname {} | \
   xargs -I {} mkdir -p ${VIMRUNTIME}{};

find ${VIMFILES} -type f | \
   sed "s=${VIMFILES}==" | \
   xargs -I {} cp $VIMFILES/{} $VIMRUNTIME{};

ln -svf ${HOME}/.config/vim/.vimrc ~/.vimrc

cd ..


cd ${HOME}
