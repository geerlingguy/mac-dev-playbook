# Mac Development Ansible Playbook

This playbook is forked from the original [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) with some significant modifications for my personal setup and to work with macOS 10.14 Mojave.

There are also a lot of manual steps that need to be completed afterwards, but I will keep track of them here and update them as I figure out ways to automate them out of existence.

As always, this is a work in progress, and is mostly a means for me to document my current (non-work) Mac's setup. There will probably be frequent changes followed by long bouts of silence until I get a new Mac in a few years.

## Installation

  1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
  2. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-on-macos).
  3. Sign in to the Mac App Store if you plan to automate install of App Store Apps.  10.14 Mojave disabled `signin` from the command line.
  4. Run `$ ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
  5. Run `ansible-playbook main.yml -i inventory -K` inside this directory to run all tasks. Enter your sudo password when prompted.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. I've added tags to almost every tags so each step can be developed/tested in isolation.

- `homebrew`
- `dotfiles`
- `mas`
- `ansible-setup`
- `macos`
- `repos-setup`
- `extra-packages`

*Example:* `ansible-playbook main.yml -i inventory -K --tags "dotfiles,homebrew"`

## Overriding Defaults

This repo is a very opinionated way of setting up your mac and everyone likes different packages, applications, defaults, etc.

If you want to change any of the default configurations just edit the appropriate section in `vars.yaml`.

## Dotfiles

My [dotfiles](https://github.com/rlipke/dotfiles) are also installed into the current user's home directory, including the `.macos` dotfile for configuring many settings and defaults of macOS for better performance and ease of use. You can disable dotfiles management by setting `configure_dotfiles: no` in your configuration.  

You can also set which dotfiles to explicitly install from your dotfiles repo by including/excluding them in the `dotfiles_files` array in `vars.yml`.

## Future additions

### Things that still need to be done manually

There are still quite a few things to do manually after this playbook is run.  Some of them I will keep attempting to automate or were previously automated until the latest version of macOS broke them. Others are just necessary setup before I consider a new mac fully functional.  

- Finder > Show PathBar
- Finder > Disable warning when changing a file extension
- Sign in to iCloud. Disable Mail.
- Internet Accounts > Enable [fastmail](https://www.fastmail.com/)
- Date and Time > set to 24 hour clock and show date
- Security > allow Apple Watch to unlock mac
- Sharing > set name to a Middle-Earth location (my ultra nerdy naming scheme)
- Dropbox - Sign in and start selective Folder sync
- 1Password - Sign in & set preferences
- iStat Menus - Don't bother copying/syncing prefs.  Setup as usual, set temps to C, activate license.
- Setup Firefox. Sign in and set as default browser, set master password, install 1password extension https://1password.com/browsers/firefox/ (not 1Password X)
- .ssh - generate new keys, add to Github
- TextExpander - login, hide dock icon, set to launch at login
- Setup Alfred. Activate PowerPack license, enable sync, swap shortcut to `⌘ + Space`, enable clipboard history.
- Copy iTerm preferences - This has been wonky lately.  Need to look into [mackup](https://github.com/lra/mackup) again or use a separate folder for each machine.
- VS Code - Create new github token with gist permissions for `Settings Sync` and one for VS Code with `repo` permissions.  Run initial `Settings Sync` download settings.  Login to Github.
- Atom sync - Create new github token with gist permissions for `sync-settings` . Run initial `settings-sync` restore. Login with Github.
- Copy .gnupg folder. Remember the passphrase dummy!
- Setup keybase - authorize new device from iPhone
- Setup Slack and 8000 teams.  Configure preferences.
- Moom - Copy preferences but don’t keep them synced since they can be open in two places.  Activate license
- Open karabiner-elements, allow scary security permissions, verify hyper is working.
- Setup hyper shortcuts: Things/Omnifocus entry, notifications, iterm visor
- copy .bash_envs
- bartender - Setup, set to login, chooose menubar icon
- iTunes - Sign in with Apple ID, enable iCloud music library, enable list view checkboxes and star ratings, enable automatic music downloads, require password for purchases after 15 minutes, free downloads never require, sync playback across devices, sync podcast subs, automatically download artwork, Advanced > share itunes library xml. Authorize device.
- Authenticate last.fm, turn off device scrobbling
- Install Eagle. Register, import library from icloud > documents > world.library
- Activate kaleidoscope license (url is in mail)

### Applications/packages to be added:

These are apps that don't currently have a brew cask or Mac App Store install. 

- [Eagle](https://en.eagle.cool/)
- [VirtualBox](https://www.virtualbox.org/) - see note below

### Configuration to be added:

- Vim config.  My .vimrc is a mess
- Sublime Text - install [Package Control](https://packagecontrol.io/installation) and sync settings/packages
- Copy ~/bin over
- VirtualBox and [Karabiner-Elements](https://pqrs.org/osx/karabiner/) may fail to install due to kext security permissions. I have seen this repeatedly with VirtualBox so I took it out of the homebrew casks for now.  Interestingly, these failures never happen on my test VM...I'm pretty sure something is getting disabled in order to for macOS to even boot but haven't figured out what yet.

## Testing the Playbook

I created a macOS 10.14 [VirtualBox](https://www.virtualbox.org/) VM mostly by using the method [here](https://github.com/AlexanderWillner/runMacOSinVirtualBox), some Hogwarts incantations and blood sacrifice. Once it's up and running, install xcode-select tools and ansible, shutdown and then clone it. You can now use a fresh VM to iterate changes on or run an entire end to end install. _*Warning*_: Vbox doesn't support guest additions for macOS, so getting things onto and off of the VM can be a pain (ie, no shared clipboard, no shared folders, etc.)

I haven't setup Travis CI testing yet.

## Author

[Ron Lipke](https://www.twitter.com/neverminding)
