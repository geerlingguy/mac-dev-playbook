<img src="https://raw.githubusercontent.com/dbrennand/mac-dev-playbook/master/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" />

# Mac Development Ansible Playbook

This Ansible playbook installs and configures most of the software I use on my Mac for web and software development. This repository is a fork of [Jeff Geerling's](https://www.jeffgeerling.com) original [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) project.

## Installation

1. Ensure Apple's command line tools are installed:

    ```bash
    xcode-select --install
    ```

2. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html):

    ```bash
    export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
    pip3 install --upgrade pip
    pip3 install ansible
    ```

3. Clone or download this repository to your Macbook.

4. Install the required Ansible roles and collections:

   ```bash
   ansible-galaxy install -r requirements.yml
   ```

5. Execute the Ansible playbook:

    ```bash
    ansible-playbook main.yml --ask-become-pass
    ```

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `homebrew`, `mas`, `dock`, `sudoers`, `terminal`, `pip-packages`, `post`.

    ansible-playbook main.yml -K --tags "homebrew"

## Included Applications / Configuration (Default)

Applications (installed with Homebrew Cask):

  - [Homebrew](http://brew.sh/)
  - [BitWarden](https://formulae.brew.sh/cask/bitwarden)
  - [Discord](https://formulae.brew.sh/cask/discord#default)
  - [Google Drive](https://formulae.brew.sh/cask/google-drive#default)
  - [Microsoft Edge](https://formulae.brew.sh/cask/microsoft-edge#default)
  - [Visual Studio Code](https://formulae.brew.sh/cask/visual-studio-code#default)
  - [Spotify](https://formulae.brew.sh/cask/spotify#default)
  - [Signal](https://formulae.brew.sh/cask/signal#default)

Packages (installed with Homebrew):

  - wget
  - httpie
  - cowsay
  - git
  - nmap
  - gpg
  - gh
  - skopeo
  - jq
  - yq
  - terraform
  - hcloud

## Testing the Playbook

Many people have asked me if I often wipe my entire workstation and start from scratch just to test changes to the playbook. Nope! This project is [continuously tested on GitHub Actions' macOS infrastructure](https://github.com/dbrennand/mac-dev-playbook/actions?query=workflow%3ACI).

You can also run macOS itself inside a VM, for at least some of the required testing (App Store apps and some proprietary software might not install properly). I currently recommend:

  - [UTM](https://mac.getutm.app)
  - [Tart](https://github.com/cirruslabs/tart)

## Ansible for DevOps

Check out [Ansible for DevOps](https://www.ansiblefordevops.com/), which teaches you how to automate almost anything with Ansible.

## Author

This repository is a fork of [Jeff Geerling's](https://www.jeffgeerling.com) original [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) project. [Jeff Geerling's](https://www.jeffgeerling.com/) project was originally inspired by [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks).
