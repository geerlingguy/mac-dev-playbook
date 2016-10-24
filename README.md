# Mac Development Ansible Playbook

[![Build Status](https://travis-ci.org/geerlingguy/mac-dev-playbook.svg?branch=master)](https://travis-ci.org/geerlingguy/mac-dev-playbook)

This playbook installs and configures most of the software I use on my Mac for web and software development. Some things in macOS are difficult to automate (notably, the Mac App Store and certain tools from Apple), so I still have some manual installation steps, but at least it's all documented here.

This is a work in progress, and is mostly a means for me to document my current Mac's setup. I'll be adding settings and packages to this set of playbooks over time.

*See also*:

  - [Battleschool](http://spencer.gibb.us/blog/2014/02/03/introducing-battleschool)
  - [osxc](https://github.com/osxc)
  - [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks) (the original inspiration for this project)

## Installation

  1. [Install Ansible](http://docs.ansible.com/intro_installation.html).
  2. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
  3. Clone this repository to your local drive.
  4. Run `$ ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
  5. Run `ansible-playbook main.yml -i inventory -K` inside this directory. Enter your account password when prompted.

> Note: If some Homebrew commands fail, you might need to agree to XCode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

## Included Applications / Configuration

Applications (installed with Homebrew Cask):

  - [Docker](https://www.docker.com/)
  - [Dropbox](https://www.dropbox.com/)
  - [Fing](https://www.fing.io/)
  - [Firefox](https://www.mozilla.org/en-US/firefox/new/)
  - [Google Chrome](https://www.google.com/chrome/)
  - [Handbrake](https://handbrake.fr/)
  - [Homebrew](http://brew.sh/)
  - [KDiff3](http://kdiff3.sourceforge.net/)
  - [LICEcap](http://www.cockos.com/licecap/)
  - [LimeChat](http://limechat.net/mac/)
  - [MacVim](http://macvim-dev.github.io/macvim/)
  - [Menu Meters](https://www.ragingmenace.com/software/menumeters/) (Note: Currently using [this fork](http://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/) for compatibility)
  - [nvALT](http://brettterpstra.com/projects/nvalt/)
  - [Sequel Pro](https://www.sequelpro.com/) (MySQL client)
  - [Skype](https://www.skype.com/en/)
  - [Skitch](https://evernote.com/skitch/)
  - [Slack](https://slack.com/)
  - [Sublime Text](https://www.sublimetext.com/)
  - [Transmit](https://panic.com/transmit/) (S/FTP client)
  - [Vagrant](https://www.vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  - [VLC](http://www.videolan.org/vlc/index.html)

Packages (installed with Homebrew):

  - autoconf
  - bash-completion
  - doxygen
  - gettext
  - git
  - go
  - gpg
  - hub
  - httpie
  - iperf
  - libdvdcss
  - libevent
  - packer
  - python
  - sqlite
  - mcrypt
  - mysql
  - npm
  - nvm
  - php70
  - php70-mcrypt
  - php70-xdebug
  - ssh-copy-id
  - cowsay
  - readline
  - subversion
  - openssl
  - pv
  - drush
  - wget
  - wrk

My [dotfiles](https://github.com/geerlingguy/dotfiles) are also installed into the current user's home directory, including the `.osx` dotfile for configuring many aspects of macOS for better performance and ease of use.

Finally, there are a few other preferences and settings added on for various apps and services.

## Future additions

### Things that still need to be done manually

It's my hope that I can get the rest of these things wrapped up into Ansible playbooks soon, but for now, these steps need to be completed manually (assuming you already have Xcode and Ansible installed, and have run this playbook).

  1. Set JJG-Term as the default Terminal theme (it's installed, but not set as default automatically).
  2. Install [Sublime Package Manager](http://sublime.wbond.net/installation).
  3. Install all the Mac App Store Apps (see below).
  4. Install all the apps that aren't yet in this setup (see below).
  5. Remap Caps Lock to Escape (keycode 53), using Karabiner Elements.
  6. Set trackpad tracking rate.
  7. Set mouse tracking rate.
  8. Configure extra Mail and/or Calendar accounts (e.g. Google, Exchange, etc.).

### Applications/packages to be added:

These are mostly direct download links, some are more difficult to install because of custom installers or other nonstandard install quirks:

  - [iShowU HD](http://downloads.shinywhitebox.com/iShowU_HD_Pro_2.3.7.dmg)
  - [Adobe Creative Cloud](http://www.adobe.com/creativecloud.html)
  - [Microsoft Office](https://products.office.com/en-us/mac/microsoft-office-for-mac)

### Configuration to be added:

  - I have vim configuration in the repo, but I still need to add the actual installation:
    ```
    mkdir -p ~/.vim/autoload
    mkdir -p ~/.vim/bundle
    cd ~/.vim/autoload
    curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim > pathogen.vim
    cd ~/.vim/bundle
    git clone git://github.com/scrooloose/nerdtree.git
    ```

### Apps only available via the App Store

I also use the following apps at least once or twice per week, but the Mac App Store is harder to control via CLI, so for now I have to manually install all of these apps from within the App Store application (see [Issue #11](https://github.com/geerlingguy/mac-dev-playbook/issues/11)).

  - Tweetbot
  - RadarScope
  - Pixelmator
  - Quick Resizer
  - 1Password
  - DaisyDisk
  - Byword
  - Aperture
  - Pages
  - Keynote
  - Numbers

## Testing the Playbook

Many people have asked me if I often wipe my entire workstation and start from scratch just to test changes to the playbook. Nope! Instead, I posted instructions for how I build a [Mac OS X VirtualBox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm), on which I can continually run and re-run this playbook to test changes and make sure things work correctly.

## Ansible for DevOps

Check out [Ansible for DevOps](https://www.ansiblefordevops.com/), which will teach you how to do some other amazing things with Ansible.

## Author

[Jeff Geerling](http://www.jeffgeerling.com/), 2014 (originally inspired by [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks)).
