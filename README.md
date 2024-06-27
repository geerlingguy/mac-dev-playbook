<img src="https://raw.githubusercontent.com/scoremedia/dev-laptop-setup/main/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" />

# Mac Development Ansible Playbook

This playbook installs and configures laptop for development work in SRE Release Engineering.

## First Time Steps

These steps should only be executed once as subsequently you will have Ansible installed via homebrew.

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
2. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html):

   1. Run the following command to add Python 3 to your $PATH temporarily: `export PATH="$HOME/Library/Python/3.9/bin:$PATH"`
   2. Upgrade Pip: `sudo pip3 install --upgrade pip`
   3. Install Ansible: `pip3 install ansible`

### Running the Playbooks

#### Setup

1. Clone or download this repository to your local drive.
1. Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.

#### SRE Release Engineering

This playbook will setup the laptop for SRE Release Engineering.

To run this: `ansible-playbook playbooks/srere-laptop-setup.yml --ask-become-pass`

It performs the following tasks:

- Installs homebrew and sets up the Jfrog repository
- Install homebrew packages, apps and taps as defined in `homebrew_installed_packages`, `homebrew_cask_apps`, `homebrew_taps` in [default.srere-laptop-setup.yml](vars_files/default.srere-laptop-setup.yml)
- Sets up the zsh shell by setting up common functions, paths variable and other environment variables.
- Sets up Git with some configurations like:
  - GPG Signing
  - Proper username and email (derived from your Mac username)
  - Default init branch set to main
  - `push.autoSetupRemote` set so you don't have to do `git push --set-upstream` when pushing a new branch
- Helm repository setup to point to the internal Helm Chart repository.

For a more accurate description please see [playbooks/srere-laptop-setup.yml](playbooks/srere-laptop-setup.yml) and the roles and tasks in it.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags that are available can be listed by running `ansible-playbook playbooks/srere-laptop-setup.yml --list-tags`.

    ansible-playbook playbooks/srere-laptop-setup.yml --ask-become-pass --tags git-config,helm-repo-setup

## Overriding Defaults

At this time this is not possible. The configuration is somewhat neccesary to do development work. When preferential configuration is added, overriding those options will be provided.

## Ansible for DevOps

Check out [Ansible for DevOps](https://www.ansiblefordevops.com/), which teaches you how to automate almost anything with Ansible.

## Author

This project was created by [Komail Kanjee](https://github.com/komailo) and was forked off [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) by [Jeff Geerling](https://www.jeffgeerling.com/) which was originally inspired by [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks).
