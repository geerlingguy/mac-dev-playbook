#!/bin/bash

export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
ansible-playbook main.yml --ask-become-pass
