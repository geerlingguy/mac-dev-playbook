# Mac Development Ansible Playbook

This set of playbooks was originally cloned from [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks), and basically installs all the software I use on my Mac for web and software development. Well, all the software I can get without using the Mac App Store, which can't be scripted.

This is very much a work in progress, and is mostly a means for me to document my current Mac's setup. I'll be adding settings and packages to this set of playbooks.

**Caveat**: This set of playbooks is not meant to be a great example of Ansible best practices. I just want to wrap my Mac's configuration in Ansible so I can quickly bring up a new development Mac without having to restore from a Time Machine backup.

## Installation

  1. Clone this repository somewhere.
  2. [Install Ansible](https://devopsu.com/guides/ansible-mac-osx.html).
  3. Run `ansible-playbook main.yml --ask-sudo-pass`.

## Additions coming soon

### General changes:

  - Fix TODOs (idempotence, mostly - maybe just pass in a 'creates' variable)

### Applications/packages to be added:

  - [MacVim](https://github.com/b4winckler/macvim/releases/download/snapshot-72/MacVim-snapshot-72-Mavericks.tbz)
  - iShowU HD
  - [MenuMeters](http://www.ragingmenace.com/software/menumeters/)
  - TextMate 2
  - PCKeyboardHack
  - My dotfiles
  - TimeMachineEditor
  - Skype
  - etc...

### Settings to be added:

  - Terminal theme (Jeff's OSX)
  - Sublime text settings/package manager
  - Keyboard remappings (Caps Lock -> escape)
  - Faster key repeat rates
  - Desktop background
  - Trackpad tracking rate
  - Mouse tracking rate
  - Finder settings:
    - Disable "show warning before changing extension"
    - Set default view to column mode
    - Show hard disks, connected servers on desktop
  - etc...

### Apps only available via the App Store

I also use the following apps at least once or twice per week, but unfortunately, as the Mac App Store is not able to be controlled via CLI, or any other way I can find (so far), I have to manually install all of these apps from within the App Store application.

  - Tweetbot
  - RadarScope
  - Pixelmator
  - Skitch
  - Quick Resizer
  - Knock
  - 1Password
  - DaisyDisk
  - Byword
  - Aperture
  - Pages
  - Keynote
  - Numbers

There are a couple other apps I'm leaving out of the list, like Microsoft Word, because I normally don't install them unless I need them; unfortunately, about once a year, I get a document that's so old/strange that I need Word or Powerpoint to open the file.

## Ansible for DevOps

If Ansible piques your interest, please check out the book I'm working on, [Ansible for DevOps](https://leanpub.com/ansible-for-devops), where I actually *do* follow Ansible best practices, and will teach you how to do some other amazing things with Ansible.

## Author

[Jeff Geerling](http://jeffgeerling.com/), 2014 (originally forked from [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks)).
