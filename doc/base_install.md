# Initial Installation

This document describes how to perform a fresh installation

---

# Overview

  * Factory Reset the Macbook
  * Base Install (with Appled ID)
  * Install Developer Tools
  * Install Ansible
  * Clone Repository
  * Install Roles
  * Run Ansible


---

# References

  * See: https://github.com/geerlingguy/mac-dev-playbook
  * See: https://hvops.com/articles/ansible-mac-osx/

*Forks*

  * https://github.com/asterr/mac-dev-playbook
  * https://github.com/asterr/dotfiles
  * https://github.com/asterr/ansible-role-mac-rosetta

---

# Procedures

---

## Factory Reset the Macbook

  * Shutdown
  * Boot with Options
    * Hold power button until Options appear
  * Use Disk Utility to wipe disk
    * Select Volume "Macintosh HD"
    * Erase the volume group
    * Might be prompted to activate Macbook with Apple ID.
  * Exit Disk Utility

---

## Base Install (Reinstall OS)

  * Shutdown
  * Boot with Options
    * Hold power button until Options appear
  * Select "Reinstall OS"
  * Need a Wifi Password


---

**REVIEW AFTER HERE**



----

Base Install:

- Aaron Sterr (asterr)
- Connect with Apple ID: asterr@pobox.com


----

Install Developer Tools

```
xcode-select --install
```

Install Ansible:

```
export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
sudo pip3 install --upgrade pip
pip3 install ansible
```

Clone Repository

```
mkdir ~/tmp
cd ~/tmp
git clone https://github.com/asterr/mac-dev-playbook.git
```

Install Roles

```
ansible-galaxy install -r requirements.yml
```


Running the Playbook

```
ansible-playbook main.yml --ask-become-pass --check -vv
ansible-playbook main.yml --ask-become-pass --check -vv --step
ansible-playbook main.yml --ask-become-pass -vv --step
```



Manual Steps:

- Need to sign in manually to the Apple Store (mas signin doesn't work)
- Create ~/.vault_pass -- super secure secret, protecting vault

