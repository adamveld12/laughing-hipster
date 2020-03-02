#!/bin/sh
ALACRITTY_VERSION=0.3.3;
curl -L https://github.com/jwilm/alacritty/releases/download/v${ALACRITTY_VERSION}/Alacritty-v${ALACRITTY_VERSION}-ubuntu_18_04_amd64.deb  > /tmp/alacritty.deb;
sudo apt install -qq -y /tmp/alacritty.deb;