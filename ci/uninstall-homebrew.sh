#!/bin/sh

# Uninstalls Homebrew using the official uninstall script.

set -e
set -o pipefail

if [ "$(id -u)" -ne 0 ]
then
    echo 'This script must be run as root.'
    exit 1
fi

# Download and run the uninstall script.
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh' | bash -s -- --force

# Clean up Homebrew directories.
rm -rf /usr/local/Homebrew
rm -rf /usr/local/Caskroom
rm -rf /usr/local/bin/brew
