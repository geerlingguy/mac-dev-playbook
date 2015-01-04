# Mac Development Ansible Playbook

This playbook installs and configures most of the software I use on my Mac for web and software development. Some things in OS X are difficult to automate (notably, the Mac App Store and certain tools from Apple), so I still have some manual installation steps, but at least it's all documented here.

This is a work in progress, and is mostly a means for me to document my current Mac's setup. I'll be adding settings and packages to this set of playbooks over time.

*See also*:

  - [Battleschool](http://spencer.gibb.us/blog/2014/02/03/introducing-battleschool) is a more general solution than what I've built here. (It may be a better option if you don't want to fork this repo and hack it for your own workstation...).
  - [osxc](https://github.com/osxc) is another more general solution, set up so you can fork the [xc-custom](https://github.com/osxc/xc-custom) repo and get your own local environment bootstrapped quickly.
  - [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks) was the original inspiration for this repository, but this project has since been completely rewritten.

## Installation

  1. [Install Ansible](http://docs.ansible.com/intro_installation.html).
  2. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
  3. Clone this repository to your local drive.
  4. Run the command `$ ansible-galaxy install -r requirements.txt` inside this directory to install required Ansible roles.
  5. Run `ansible-playbook main.yml -i inventory --ask-sudo-pass` from the same directory as this README file.

## Included Applications / Configuration

The following applications are automagically installed:

  - Adium
  - BetterTouchTool
  - Google Chrome
  - Dropbox
  - Firefox
  - Handbrake
  - Homebrew
  - Menu Meters
  - nvALT
  - Sequel Pro (MySQL client)
  - Skype
  - Skitch
  - Sublime Text
  - Tower (Git client)
  - Transmit (S/FTP client)
  - Vagrant
  - VirtualBox
  - VLC

The following homebrew packages are automagically installed:

  - autoconf
  - gettext
  - libevent
  - packer
  - python
  - sqlite
  - mysql
  - ssh-copy-id
  - cowsay
  - ios-sim
  - readline
  - subversion
  - kdiff3
  - openssl
  - pv
  - wget
  - caskroom/cask/brew-cask

Jeff Geerling's [dotfiles](https://github.com/geerlingguy/dotfiles) are also installed into the current user's home directory, including the `.osx` dotfile for configuring many aspects of Mac OS X for better performance and ease of use.

Finally, there are a few other preferences and settings added on for various apps and services.

## Future additions

### Things that still need to be done manually

It's my hope that I can get the rest of these things wrapped up into Ansible playbooks soon, but for now, these steps need to be completed manually (assuming you already have Xcode and Ansible installed, and have run this playbook).

  1. Install JJG-Term.terminal theme (double-click to install).
  2. Install [Sublime Package Manager](http://sublime.wbond.net/installation).
  3. Install all the Mac App Store Apps (see below).
  4. Install all the apps that aren't yet in this setup (see below).
  5. Remap Caps Lock to Escape (keycode 53), using [Seil](https://pqrs.org/osx/karabiner/seil.html.en).
  6. Set trackpad tracking rate.
  7. Set mouse tracking rate.
  8. Set up iCloud (this was presumably done already during system setup, anyways).
  9. Configure extra Mail and/or Calendar accounts (e.g. Google, Exchange, etc.).

### Applications/packages to be added:

These are mostly direct download links, some are more difficult to install because of custom installers or other nonstandard install quirks:

  - [iShowU HD](http://downloads.shinywhitebox.com/iShowU_HD_Pro_2.3.7.dmg)
  - [TextMate 2](https://api.textmate.org/downloads/release)
  - [TimeMachineEditor](http://timesoftware.free.fr/timemachineeditor/TimeMachineEditor.zip)

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

I also use the following apps at least once or twice per week, but unfortunately, as the Mac App Store is not able to be controlled via CLI, or any other way I can find (so far), I have to manually install all of these apps from within the App Store application.

  - Tweetbot
  - RadarScope
  - Pixelmator
  - Skitch
  - Quick Resizer
  - 1Password
  - DaisyDisk
  - Byword
  - Aperture
  - Pages
  - Keynote
  - Numbers

There are a couple other apps I'm leaving out of the list, like Microsoft Word, because I normally don't install them unless/until I need them.

## Ansible for DevOps

Check out [Ansible for DevOps](https://leanpub.com/ansible-for-devops), which will teach you how to do some other amazing things with Ansible.

## Author

[Jeff Geerling](http://jeffgeerling.com/), 2014 (originally forked from [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks)).
