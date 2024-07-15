# Mac Development Ansible Playbook

[![CI](https://github.com/kdkasad/mac-dev-playbook/actions/workflows/ci.yml/badge.svg)](https://github.com/kdkasad/mac-dev-playbook/actions/workflows/ci.yml)  
<img src="https://forthebadge.com/images/badges/gluten-free.svg" alt="Gluten Free badge" height=30 />
<img src="https://forthebadge.com/images/badges/uses-badges.svg" alt="Uses Badges badge" height=30 />  
<img src="https://forthebadge.com/images/badges/works-on-my-machine-1.svg" alt="It Works On My Machine badge" height=30 />

This playbook installs and configures most of the software I use on my Mac.

This playbook defines *how* to install and set up a machine,
but most of the information on *what* to install and set up is stored in
[my dotfiles repository](https://github.com/kdkasad/dotfiles).
For example, what packages/apps to install, which items to place in the dock,
default settings, etc. are all stored as dotfiles.

## Installation

  1. Clone or download this repository to your local drive.
  2. Run `./install.sh` inside this directory. The script will install the
     required tools and run the playbook.
  3. At the beginning of the playbook, you will be prompted to enter your MacOS
     account password (i.e. what you'd use for `sudo`), called the "BECOME"
     password by Ansible.
  4. You may be prompted for your account password again when installation of
     Homebrew cask apps begins. This is because Homebrew uses `sudo`. You can
     set the `ansible_become_password` variable to avoid this.

> [!NOTE]
> If some Homebrew commands fail,
> you might need to agree to Xcode's license or fix some other Brew issue.
> Run `/opt/homebrew/bin/brew doctor` to see if this is the case.

### Use with a remote Mac

You can use this playbook to manage other Macs as well;
the playbook doesn't even need to be run from a Mac at all!
If you want to manage a remote Mac,
you just need to make sure you can connect to it with SSH:

  1. On the Mac you want to connect to, go to System Preferences > Sharing.
  2. Enable 'Remote Login'.

> [!NOTE]
> You can also enable remote login on the command line:
>
> ```
> sudo systemsetup -setremotelogin on
> ```

Then edit the `inventory` file in this repository and change the line that
starts with `127.0.0.1` to:

```
<ip address or hostname of mac>  ansible_user=<mac ssh username>
```

If you need to supply an SSH password (if you don't use SSH keys), make sure to
pass the `-k / --ask-pass` parameter to the `ansible-playbook` command.

## Author

This project is maintained by Kian Kasad.
It was originally forked from
[Jeff Geerling's mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook),
which itself was inspired by
[MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks).
