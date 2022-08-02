#!/bin/bash

xcode-select --install

sudo pip3 install --upgrade pip
pip3 install ansible

ansible-galaxy install -r requirements.yml

brew install jq
DLURL=$(curl --silent "https://api.github.com/repos/kcrawford/dockutil/releases/latest" | jq -r .assets[].browser_download_url | grep pkg)
curl -sL ${DLURL} -o /tmp/dockutil.pkg
sudo installer -pkg "/tmp/dockutil.pkg" -target /
rm /tmp/dockutil.pkg


