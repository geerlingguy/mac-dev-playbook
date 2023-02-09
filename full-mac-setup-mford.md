# Full Mac Setup Process (for Michael Ford)

There are some things in life that just can't be automated... or aren't 100% worth the time :(

This document covers that, at least in terms of setting up a brand new Mac out of the box.

These instructions assume that the playbook and ansible are installed on a remote linux machine.

## Initial configuration of a brand new Mac

Before starting, I completed Apple's mandatory macOS setup wizard (creating a local user account, and optionally signing into my iCloud account). Once on the macOS desktop, I do the following (in order):

  - SSH setup.
    - Manually copy any shared SSH keys that are needed to log into the remote Ansible machine, from Dropbox (via Airdrop or Web GUI)
  - Turn on remote SSH access on Mac
  - Ensure that the approprpiate SSH Private key that allows remote access is populated in ~/.ssh/authorized_keys
  - Sign into:
    - iCloud
    - iMessage
    - Mac App Store
  - `sudo softwareupdate --install-rosetta` (required to install adobe acrobat)
  - Run the playbook remotely with `--tags homebrew, sudoers`.
    - If there are errors, you may need to finish up other tasks like installing 'old-fashioned' apps first
  - Ensure that the homebrew binary directory is assed to the PATH:
    - `$ export PATH=/opt/homebrew/bin:$PATH`
  - Install old-fashioned apps:
    - Install [Insta360 Link](https://www.insta360.com/download/insta360-link)
    - Install [Google Chat](https://chat.google.com/download/) from within Brave Browser
    - Install [VMWare Fusion Player](https://customerconnect.vmware.com/en/evalcenter?p=fusion-player-personal-13) (dmg file and licence are in DropBox)
  - Set up Dropbox and sync the following folders:
    - `/Dropbox/apps/`
    - `/Dropbox/My Documents/Macbook Ansible Restore/`
  - Run the playbook remotely with `--skip-tags homebrew, post`.
  - Manual settings to automate someday:
    - System Settings
      - Wi-Fi
        - Set Wireless SSID and DNS Server to Pihole
      - Privacy & Security
        - Privacy
          - Screen Recording
            - Give the following apps permissions
              - Amazon Chime
              - Brave Browser
              - FaceTime
              - Google Chrome
              - Microsoft Teams
              - WebEx
              - zoom.us
      - Desktop & Dock
        - Show recent applications in dock: `disabled`
        - Hot Corners
          - Upper Left: `Notification Center`
          - Lower Left: `Lock Screen`
          - Upper Right: `-`
          - Lower Right: `Put Display to Sleep` 
      - Touch ID & Password
        - Add Fingerprints for TouchID
        - Allow Apple Watch to Unlock Mac   
      - Internet Accounts
        - Set up Google Account and sync contacts with Mac
      - Trackpad
        - Tap to Click: `Enabled`
          - Tap with one finger
        - App Exposé: `Swipe Down with Four Fingers`
    - Google Chrome/Brave Browser:
      - Install Google Chrome/Brave Browser extensions (list in DropBox)
      - Import Google Chrome/Brave Browser bookmarks from Dropbox
      - Set Brave Browser to default
      - Set Brave Browser default search engine to Google
    - Configure Wireguard
    - Sign into Slack workspaces (list in DropBox)
    - Apps to Authenticate with License Keys (list in DropBox):
      - ExpressVPN
      - CleanmyMac
      - Al Dente


## To Wrap in Post-provision automation

The following tasks have to wait for the initial Dropbox sync to complete before they'll succeed. So ideally I'll stick this all in a post-provision script but somehow flag it not to run on first provision.

```
# git settings
- Add Git credentials

#Install Ansible in Virtual Environment
`$ source ~/venvs/ansible/bin/activate`
`(ansible)$ pip install --upgrade pip`
`(ansible)$ pip install ansible-core==2.14.1` (as of this writing; see a list of ansible core releases [here](https://pypi.org/project/ansible-core/#history))

```

## When formatting old Mac
  - Deauthorize Apple Music in iTunes/Music App
  - Deauthorize ExpressVPN
  - Deauthorize CleanMyMac
  - Follow Apple's guide (TODO)
