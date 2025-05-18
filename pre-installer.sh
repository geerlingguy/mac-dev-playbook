#!/bin/bash

xcode-select --install
xcodebuild -license accept

if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
sudo pip3 install --upgrade pip
# pip3 install ansible

brew install ansible  # this seems to work better

ansible-galaxy install -r requirements.yml

brew install jq
DLURL=$(curl --silent "https://api.github.com/repos/kcrawford/dockutil/releases/latest" | jq -r .assets[].browser_download_url | grep pkg)
curl -sL ${DLURL} -o /tmp/dockutil.pkg
sudo installer -pkg "/tmp/dockutil.pkg" -target /
rm /tmp/dockutil.pkg

brew install svn

sudo softwareupdate --install-rosetta
