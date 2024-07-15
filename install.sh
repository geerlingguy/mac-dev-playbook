#!/bin/sh

###
### Installs MacOS command-line tools & Ansible, then runs the playbook
###

set -e
set -o pipefail

info() {
    printf "\x1b[1;34mInfo\x1b[m: "
    echo "$@"
}

if ! xcode-select -p >/dev/null 2>&1
then
    info Command-line tools are not installed.
    info Starting installation process. Use the dialog window to complete installation.
    info Once installation completes, this script will continue automatically.
    xcode-select --install 2>/dev/null
    while ! xcode-select -p >/dev/null 2>&1
    do
        sleep 5
    done
    echo
    info Command-line tools installation detected. Continuing...
    echo
fi

info Creating Python virtual environment...
python3 -m venv ./venv
source venv/bin/activate

info Updating pip...
python3 -m pip install --upgrade pip

info Installing Ansible...
python3 -m pip install ansible

info Installing Ansible dependencies...
ansible-galaxy install -r requirements.yml

info Running playbook
ansible-playbook -K main.yml "$@"
