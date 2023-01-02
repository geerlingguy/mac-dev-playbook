# Full Mac Setup Process (for Michael Ford)

There are some things in life that just can't be automated... or aren't 100% worth the time :(

This document covers that, at least in terms of setting up a brand new Mac out of the box.

## Initial configuration of a brand new Mac

Before starting, I completed Apple's mandatory macOS setup wizard (creating a local user account, and optionally signing into my iCloud account). Once on the macOS desktop, I do the following (in order):

  - SSH setup.
    - Manually copy any shared SSH keys that are needed from Dropbox
  - Turn on remote SSH access on Mac
  - Ensure that the approprpiate SSH Private key is populated in ~/.ssh/authorized_keys
  - Sign into:
    - iCloud
    - iMessage
    - Mac App Store
  - `sudo softwareupdate --install-rosetta` (required to install adobe acrobat)
  - Run the playbook remotely with `--tags homebrew, sudoers`.
    - If there are errors, you may need to finish up other tasks like installing 'old-fashioned' apps first
  - Ensure that the homebrew binary directory is assed to the PATH:
    - `export PATH=/opt/homebrew/bin:$PATH`
  - Install old-fashioned apps:
    - Install [Insta360 Link](https://www.insta360.com/download/insta360-link)
    - Install [Google Chat](https://chat.google.com/download/) from within Brave Browser
   - Run the playbook remotely with `--skip-tags homebrew,post`.
  - System Settings
    - Set Wireless SSID and DNS Server to Pihole
    - Desktop & Dock
      - Show recent applications in dock: `disabled`
    - Hot Corners
      - Upper Left: `-`
      - Lower Left: `Lock Screen`
      - Upper Right: `-`
      - Lower Right: `Put Display to Sleep`
    - Trackpad
      - Tap to Click: `Enabled`
        - Tap with one finger
      - App Exposé: `Swipe Down with Four Fingers`
    - Add Screen Sharing Rights to the following Apps (Security & Privacy --> Screen Recording):
      - Zoom
      - BlueJeans
      - Microsoft Teams
      - FaceTime
      - Google Chrome
  - Manual settings to automate someday:
    - Google Chrome/Brave Browser:
      - Install Google Chrome/Brave Browser extensions (list in DropBox)
      - Import Google Chrome/Brave Browser bookmarks from Dropbox
      - Set Brave Browser to default
      - Set Brave Browser default search engine to Google
    - Dock:
      - Add Downloads folder
    - Configure Wireguard
    - Sign into Slack workspaces (list in DropBox)
    - Apps to Authenticate:
      - ExpressVPN
      - CleanmyMac
      - Al Dente
    - Add configurations for:
      - awscli
      - git


## To Wrap in Post-provision automation

The following tasks have to wait for the initial Dropbox sync to complete before they'll succeed. So ideally I'll stick this all in a post-provision script but somehow flag it not to run on first provision.

```

# Ansible setup.
sudo mkdir -p /etc/ansible
sudo ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/ansible.cfg /etc/ansible/ansible.cfg
sudo ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/hosts /etc/ansible/hosts
sudo ln -s /Users/jgeerling/Dropbox/VMs/roles /etc/ansible/roles
mkdir -p /Users/jgeerling/.ansible
ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/galaxy_token /Users/jgeerling/.ansible/galaxy_token
ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/mm-vault-password.txt /Users/jgeerling/.ansible/mm-vault-password.txt
ln -s /Users/jgeerling/Dropbox/VMs/ /Users/jgeerling/.ansible/collections


```

## When formatting old Mac
  - Deauthorize Apple Music in iTunes/Music App
  - Deauthorize ExpressVPN
  - Deauthorize CleanMyMac
  - Follow Apple's guide (TODO)
