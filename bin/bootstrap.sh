#!/bin/bash

alias python=python3
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
export PATH="$HOME/Library/Python/3.8/bin/:$PATH"

xcode-select --install

pip install --user ansible

ansible-galaxy install -r requirements.yml
ansible-playbook main.yml -i inventory --ask-become-pass

pyenv install 3.8.7
pyenv global 3.8.7
