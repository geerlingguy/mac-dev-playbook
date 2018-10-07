#!/bin/bash

# Get my Dotfiles

if [ ! -f "$HOME/dotfiles/linker.sh" ]; then
    git clone https://github.com/j-wang/dotfiles $HOME/dotfiles && \
        $HOME/dotfiles/linker.sh
fi

# Specify link with iTerm preferences

defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2profile"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Create settings for other editors

defaults write com.jetbrains.intellij.ce ApplePressAndHoldEnabled -bool false
defaults write com.google.android.studio ApplePressAndHoldEnabled -bool false

# Installing NPM seperately from Node (which should already exist)

if [ ! -x "$(which npm)" ]; then
    echo prefix=~/.npm-packages >> ~/.npmrc && \
        curl -L https://www.npmjs.com/install.sh | sh
fi

# Install powerline fonts and Spacemacs

if [ ! -d "$HOME/.emacs.d" ]; then
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

# Setup zsh
exec zsh

# Go Setup
go get -u github.com/nsf/gocode

# Setup Pyenv default environment
if [ ! -d "$(pyenv root)/versions/anaconda3-5.2.0" ]; then
    pyenv install anaconda3-5.2.0
    # pyenv global anaconda3-5.2.0  # unknown how this affects ansible, can turn on later
fi

# Ocaml / Reason Setup
# Already idempotent if you include -n

opam init -n
eval `opam config env`
opam install -y ocp-indent
opam install -y merlin

opam update
opam switch 4.02.3+buckle-master
eval `opam config env`
opam install -y ocp-indent
opam install -y merlin
