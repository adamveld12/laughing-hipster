#!/bin/sh

wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb;
sudo dpkg -i /tmp/packages-microsoft-prod.deb;
sudo apt-get update -qq;
sudo apt-get install -y -qq dotnet-sdk-3.0;
