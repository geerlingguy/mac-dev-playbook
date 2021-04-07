#!/bin/bash
alias python=python3
pyenv install --list | grep -Ev '[abc-]' | tail -1
python -V 2>&1 | awk '/Python/{ split($2, a, "."); print a[1]"."a[2] }'

if curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py ;
then
python get-pip.py
fi

export PATH="$HOME/Library/Python/${pyver}/bin/:$PATH"
python -m pip install --user ansible

xcode-select --install > /dev/null 2>&1
if [ "$?" == '0' ]; then
  sleep 1
    osascript <<EOD
tell application "System Events"
    tell process "Install Command Line Developer Tools"
        keystroke return
        click button "Agree" of window "License Agreement"
    end tell
end tell
EOD
else
    echo "Command Line Developer Tools are already installed!"
fi

sudo systemsetup -setremotelogin on


