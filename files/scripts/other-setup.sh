#!/bin/bash

# Get my Dotfiles

if [ ! -f "$HOME/dotfiles/linker.sh" ]; then
    git clone https://github.com/j-wang/dotfiles $HOME/dotfiles && \
        $HOME/dotfiles/linker.sh
fi

# Specify link with iTerm preferences

defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

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

# Setup zsh
exec zsh

# Go Setup
go get -u github.com/nsf/gocode

# NOT YET IDEMPOTENT, RUN MANUALLY

# Setup Pyenv default environment

# pyenv install anaconda3-5.1.0
# pyenv global anaconda3-5.1.0


# Ocaml / Reason Setup

# opam init
# eval `opam config env`
# opam install -y ocp-indent
# opam install -y merlin

# opam update
# opam switch 4.02.3+buckle-master
# eval `opam config env`
# opam install -y ocp-indent
# opam install -y merlin
