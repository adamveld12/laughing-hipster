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
  nvm \
  openssl \
  python \
  rbenv \
  ruby-build \
  tmux \
  wget;

brew install go --cross-compile-all;
brew install macvim --override-system-vim --with-lua --with-python;

brew link --force openssl;

rbenv install 1.9.3-p125;
rbenv global 1.9.3-p125;
