# Full Mac Setup Process (for Jeff Geerling)

There are some things in life that just can't be automated... or aren't 100% worth the time :(

This document covers that, at least in terms of setting up a brand new Mac out of the box.

## Initial configuration of a brand new Mac

Before starting, I completed Apple's mandatory macOS setup wizard (creating a local user account, and optionally signing into my iCloud account). Once on the macOS desktop, I do the following (in order):

  - Install Ansible (following the guide in [README.md](README.md))
  - **Sign in to App Store** (since `mas` can't sign in automatically)
  - Clone mac-dev-playbook to the Mac: `git clone git@github.com:geerlingguy/mac-dev-playbook.git`
  - Drop `config.yml` from `~/Dropbox/Apps/Config` to the playbook (copy over the network or using a USB flash drive).
  - Run the playbook.
    - If there are errors, you may need to finish up other tasks like installing 'old-fashioned' apps first (since I try to place Photoshop in the Dock and it can't be installed automatically). Then, run the playbook again ;)
  - Start Synchronization tasks:
    - Open Photos and make sure iCloud sync options are correct
    - Open Music, make sure computer is authorized, and set Library sync options
    - Open Dropbox, sign in, and set up sync
  - Install or complete setup for old-fashioned apps:
    - Open Creative Cloud, sign in, and install needed apps
    - Open iStat Menus and configure CPU/Net/Temp Combined view
    - (If required:)
      - Install [Elgato Stream Deck](https://www.elgato.com/en/downloads)
        - Open Livestream profile inside `~/Dropbox/Apps/Config/Stream Deck`
      - Install [Elgato Key Light Air (Control Center)](https://www.elgato.com/en/downloads)
      - Install [Autodesk Fusion 360](https://www.autodesk.com)
      - Install Microsoft Office Home & Student 2019 (https://account.microsoft.com/services/)
      - Install [Fritzing](https://fritzing.org/download/)
  - Configure FastMail account:
    - Log into Fastmail
    - Go to settings, then Privacy & Security
    - Create a new app password, and on that page, download the configuration file
    - Open the downloaded profile, then go to System Preferences, and Device Management
    - Double-click on the Fastmail profile
    - Click 'Install...' and install it
    - Configure which accounts are enabled in the 'Internet Accounts' System Preferences pane
  - Open Calendar and enable personal Google CalDAV account (you have to manually sign in).
  - Manually copy `~/Development` folder from another Mac (to save time).
  - Manual settings to automate someday:
    - Finder:
      - Disable click-to-show Desktop: `defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false`
    - System Preferences:
      - Accessibility > Display > Reduce transparency
      - Keyboard > Keyboard Shortcuts... > Modifier Keys... > Caps Lock to Esc
      - Keyboard > Key repeat rate to 'Fast', Delay until repeat to 'Short'
      - Privacy & Security > Full Disk Access > enable "Terminal"
    - Safari:
      - View > Show Status Bar
      - Preferences > Advanced > "Show full website address"
      - Preferences > Advanced > "Show features for web developers"
      - Install the 'Return YouTube Dislike' Userscript in Userscripts
    - Dock:
      - Add jgeerling, Downloads, Applications, and shared "mercury" folders
  - Final Cut Pro
    - Install FxFactory and sign in: https://fxfactory.com
    - Copy contents of `~/Development/youtube/fcpx` into respective directories
  - These things might be automatable, but I do them manually right now:
    - Configure Time Machine backup drive
    - Install Wireguard VPN configurations (if needed)

## To Wrap in Post-provision automation

The following tasks have to wait for the initial Dropbox sync to complete before they'll succeed. So ideally I'll stick this all in a post-provision script but somehow flag it not to run on first provision.

```
# ZSH Aliases.
ln -s /Users/jgeerling/Dropbox/Apps/Config/.aliases /Users/jgeerling/.aliases

# Electrum BTC Wallet (open Electrum first).
ln -s /Users/jgeerling/Dropbox/Apps/Electrum/default_wallet /Users/jgeerling/.electrum/wallets/default_wallet

# SSH setup.
ssh-keygen  # and create a default key to set up .ssh folder
sudo ln -s /Users/jgeerling/Dropbox/Apps/Config/ssh/config ~/.ssh/config
# TODO - Manually copy any shared SSH keys that are needed.

# Ansible setup.
sudo mkdir -p /etc/ansible
sudo ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/ansible.cfg /etc/ansible/ansible.cfg
sudo ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/hosts /etc/ansible/hosts
sudo ln -s /Users/jgeerling/Dropbox/VMs/roles /etc/ansible/roles
mkdir -p /Users/jgeerling/.ansible
ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/galaxy_token /Users/jgeerling/.ansible/galaxy_token
ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/mm-vault-password.txt /Users/jgeerling/.ansible/mm-vault-password.txt
ln -s /Users/jgeerling/Dropbox/VMs/ansible_collections /Users/jgeerling/.ansible/collections

# Final Cut Pro setup. (Open Motion first)
cp -r /Users/jgeerling/Dropbox/Apps/Config/Motion/Motion\ Templates.localized/ /Users/jgeerling/Movies/Motion\ Templates.localized/
cp -r /Users/jgeerling/Dropbox/Apps/Config/Motion/Text\ Styles/ /Users/jgeerling/Library/Application\ Support/Motion/Library/Text\ Styles.localized/

# Sequel Ace favorites. (Open Sequel Ace first)
cp /Users/jgeerling/Dropbox/Apps/Config/Sequel\ Ace/Favorites.plist /Users/jgeerling/Library/Containers/com.sequel-ace.sequel-ace/Data/Library/Application\ Support/Sequel\ Ace/Data/Favorites.plist

# Font setup.
cp ~/Dropbox/Apps/Config/Fonts/* ~/Library/Fonts/

# Vim setup.
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle
cd ~/.vim/autoload
curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim > pathogen.vim
cd ~/.vim/bundle
git clone https://github.com/preservim/nerdtree.git
```

## When formatting old Mac

  - Sign out of Adobe Creative Cloud
  - Sign out of Panic Sync in Transmit
  - Deauthorize Apple Music in iTunes/Music App
  - Make sure anything new merged into `~/Dropbox/Apps/Config`:
    - Fonts from ~/Library/Fonts
    - Motion Plugins from ~/Movies/Motion
    - Final Cut Pro Text Styles in ~/Library/Application Support/Motion/Library/Text Styles
    - Sequel Ace shortcuts from ~/Library/Containers/com.sequel-ace.sequel-ace/Data/Library/Application\ Support/Sequel\ Ace/Data/Favorites.plist
  - Follow Apple's guide [here](https://support.apple.com/en-au/HT212749)
