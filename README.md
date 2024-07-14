# Mac Development Ansible Playbook

<!-- [![CI][badge-gh-actions]][link-gh-actions] -->

This playbook installs and configures most of the software I use on my Mac for web and software development. Some things in macOS are slightly difficult to automate, so I still have a few manual installation steps, but at least it's all documented here.

## Installation

  1. Clone or download this repository to your local drive.
  4. Run `./install.sh` inside this directory. The script will install the required tools and run the playbook.
  5. Enter your MacOS account password (i.e. what you'd use for `sudo`) when prompted for the 'BECOME' password.

> [!NOTE]
> If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Use with a remote Mac

You can use this playbook to manage other Macs as well; the playbook doesn't even need to be run from a Mac at all! If you want to manage a remote Mac, either another Mac on your network, or a hosted Mac like the ones from [MacStadium](https://www.macstadium.com), you just need to make sure you can connect to it with SSH:

  1. (On the Mac you want to connect to:) Go to System Preferences > Sharing.
  2. Enable 'Remote Login'.

> You can also enable remote login on the command line:
>
>     sudo systemsetup -setremotelogin on

Then edit the `inventory` file in this repository and change the line that starts with `127.0.0.1` to:

```
[ip address or hostname of mac]  ansible_user=[mac ssh username]
```

If you need to supply an SSH password (if you don't use SSH keys), make sure to pass the `--ask-pass` parameter to the `ansible-playbook` command.

## Author

This project is customized by Kian Kasad, and based on
[Jeff Geerling's mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook),
which itself was inspired by
[MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks).
