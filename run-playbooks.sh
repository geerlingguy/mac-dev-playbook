#!/bin/bash

# Required for Apple Silicon
export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
export PATH=/opt/homebrew/opt/ruby/bin:$PATH
export PATH=`gem environment gemdir`/bin:$PATH

ansible-playbook main.yml --ask-become-pass
