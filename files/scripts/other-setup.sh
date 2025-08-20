#!/bin/bash

echo "Starting other scripts..."

# Get my Dotfiles

if [ ! -f "$HOME/dotfiles/linker.sh" ]; then
    git clone https://github.com/j-wang/dotfiles $HOME/dotfiles && \
        $HOME/dotfiles/linker.sh
fi

# Specify link with iTerm preferences

sudo ln -s /opt/homebrew/bin/zsh /usr/local/bin/zsh  # required for iTerm function

defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2profile"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Create settings for other editors

defaults write com.jetbrains.intellij.ce ApplePressAndHoldEnabled -bool false
defaults write com.google.android.studio ApplePressAndHoldEnabled -bool false

# Link VeraCrypt

ln -s /Applications/VeraCrypt.app/Contents/MacOS/Veracrypt /usr/local/bin/veracrypt

# Turn on Full Keyboard Access for all controls

defaults write -g AppleKeyboardUIMode -int 2 

# Install powerline fonts and Spacemacs

if [ ! -f "$HOME/.emacs.d/spacemacs.mk" ]; then
    echo "Installing Spacemacs..."
    rm -rf $HOME/.emacs.d
    git clone https://github.com/powerline/fonts.git $HOME/fonts && \
        $HOME/fonts/install.sh && \
        rm -rf $HOME/fonts
    git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d
fi

# Install Superhuman
if [ ! -d "/Applications/Superhuman.app" ]; then
    curl https://download.superhuman.com/Superhuman.dmg -o /tmp/Superhuman.dmg
    hdiutil mount /tmp/Superhuman.dmg
    sudo cp -R "/Volumes/Superhuman/Superhuman.app" /Applications && \
        hdiutil unmount "Volumes/Superhuman/"
fi

# Go Setup
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

