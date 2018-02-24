#!/bin/bash

if [ -d "${dest}/.config" ]; then
  echo ".config exists"
else
  mkdir -p "${dest}/.config"
fi

cp -r ${source}/config/ ${dest}/.config/

sudo apt-get update && sudo apt-get install \
  build-essential \
  cmake \
  curl \
  nvm \
  python \
  rbenv \
  tmux \
  wget \
  git;


rbenv install 1.9.3-p125;
rbenv global 1.9.3-p125;

rm -rf ~/tools/modules/iTerm2-Color-Schemes
rm -rf ~/tools/modules/tmux-MacOSX-pasteboard

rake

echo "You must install YouCompleteMe by going to ~/tools/vim/bundle/YouCompleteMe/ and following the instructions in the README.md"
