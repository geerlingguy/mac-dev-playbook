# Mac Development VM

This set of playbooks was originally cloned from [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks), and basically installs all the software I use on my Mac for web and software development. Well, all the software I can get without using the Mac App Store, which can't be scripted.

This is very much a work in progress, and is mostly a means for me to document my current Mac's setup. I'll be adding settings and packages to this set of playbooks.

**Caveat**: This set of playbooks is not meant to be a great example of Ansible best practices. I just want to wrap my Mac's configuration in Ansible so I can quickly bring up a new development Mac without having to restore from a Time Machine backup.

## Additions coming soon

### General changes:

  - Don't uninstall/replace already-installed applications.

### Applications/packages to be added:

  - Cornerstone SVN
  - Tower (Git)
  - PCKeyboardHack
  - etc...

### Settings to be added:

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

## Ansible for DevOps

If Ansible piques your interest, please check out the book I'm working on, [Ansible for DevOps](https://leanpub.com/ansible-for-devops), where I actually *do* follow Ansible best practices, and will teach you how to do some other amazing things with Ansible.

## Author

[Jeff Geerling](http://jeffgeerling.com/), 2014 (originally forked from [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks)).
