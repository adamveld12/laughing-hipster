#!/bin/bash

if [ ! -d  ${dest}/config ]; then
  mkdir -p ${dest}/.config/
  cp -R ${source}/config/ ${dest}/.config/
fi

apt-get update && apt-get install -y \
  build-essential \
  checkinstall \
  cargo \
  cmake \
  cmake-data \
  compton \
  curl \
  git \
  i3-wm \
  nitrogen \
  python \
  rbenv \
  ruby-build \
  rust \
  tmux \
  terminator \
  wget \
  libcairo2-dev \
  libxcb1-dev \
  libxcb-ewmh-dev \
  libxcb-icccm4-dev \
  libxcb-image0-dev \
  libxcb-randr0-dev \
  libxcb-util0-dev \
  libxcb-xkb-dev \
  libxcb-xrm-dev \
  libasound2-dev \
  libssl-dev \
  libpulse-dev \
  libmpdclient-dev \
  libiw-dev \
  libcurl4-openssl-dev \
  libxcb-cursor-dev \
  snap \
  pkg-config \
  python-xcbgen \
  xcb-proto;

snap install slack;

curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash

cd ${dest}/projects

# install polybar
git clone --branch 3.1.0 --recursive https://github.com/jaagr/polybar polybar
cd ./polybar
./build.sh
cd ..


# install vim with all of the necessary features
git clone https://github.com/vim/vim vim
cd ./vim

./configure --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp=yes \
  --enable-python3interp=yes \
  --enable-perlinterp=yes \
  --enable-luainterp=yes \
  --enable-gui=gtk2 \
  --enable-cscope \
  --prefix=/usr/local

make VIMRUNTUME=~/tools/vim/

checkinstall
cd ..

git clone https://github.com/51v4n/i3-gnome i3-gnome
cd ./i3-gnome
make install
cd ..

cd ${dest}
