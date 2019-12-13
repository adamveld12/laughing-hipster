#!/bin/sh
# install polybar
git clone --branch 3.4.0 --recursive https://github.com/polybar/polybar polybar
cd ./polybar/build
cmake ..
make -j$(nproc)
sudo make install
cd ../..
rm -rf ./polybar
