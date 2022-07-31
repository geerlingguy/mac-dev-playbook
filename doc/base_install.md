See: https://github.com/geerlingguy/mac-dev-playbook
See: https://hvops.com/articles/ansible-mac-osx/

----
Forks:
- https://github.com/asterr/mac-dev-playbook


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

