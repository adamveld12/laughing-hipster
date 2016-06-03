#!/bin/bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";

brew update && brew install \
  brew-cask \
  cmake \
  curl \
  docker\
  docker-compose \
  docker-machine \
  git \
  gnupg \
  mono \
  nvm \
  openssl \
  python \
  rbenv \
  ruby-build \
  tmux \
  wget;

brew install go --cross-compile-all;

brew link --force openssl;

rbenv install 1.9.3-p125;
rbenv global 1.9.3-p125;

brew install macvim --override-system-vim --with-lua --with-python;

rake

~/tools/vim/bundle/YouCompleteMe/install.py --all

