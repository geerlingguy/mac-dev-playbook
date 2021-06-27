# config.yml helper
In adapting [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook), preparing the config.yml file can be somewhat tedious. I found the following bash one-liners helpful, you may too. You'll want to clean up the output, but it should get you most of the way there.

### Brewfile
The brew file has 4 parts, taps, brew, cask, mas. For the most part `sed` will filter out the parts you need, first dump your `Brewfile`...
```bash
brew bundle dump
```
...then take a look a how well  `sed` works.
```bash
cat Brewfile| grep -e tap
```
```bash
cat Brewfile| grep -e brew
```
```bash
cat Brewfile| grep -e cask
```
```bash
cat Brewfile| grep -e mas
```

You can build up your `config.yml` section by section. I piped the following commands to `pbcopy` and cleaned up in the `config.yml` file directly. 
```bash
cat Brewfile | grep -e tap | awk '{print "  - "$2}' | pbcopy
```
```bash
cat Brewfile | grep -e brew | awk '{print "  - "$2 }' | pbcopy
```
```bash
cat Brewfile| grep -e cask | awk '{print "  - "$2 }' | pbcopy
```
```bash
cat Brewfile | grep -e mas |  awk '{print "  - { id: "$4", name: "$2 "}"}' | pbcopy
```

### Gems
```bash
gem query --local | awk '{ print "  - name: " $1 }' | pbcopy
```

### Node
```bash  
npm ll -g --depth 0 | awk '{ print " - name:" $2 }' | tail -n +2 | pbcopy
```

### Pip
```bash  
pip list | awk '{ print "- name:"$1 }' | tail -n +3 | pbcopy
```

### Combining the commands
Depending on how you want to go about this, sometimes I feel clever to pack up a bunch of commands in to an array and execute them, below is one such example without the copying to the clipboard. I personally found that I had too many packages to review so I opted with the above.

```bash
#!/bin/bash 

backup_commands=(
  "brew bundle dump"
  "cat Brewfile | grep -e tap | awk '{print "  - "$2}'"
  "cat Brewfile | grep -e brew | awk '{print "  - "$2 }'"
  "cat Brewfile | grep -e mas |  awk '{print "  - { id: "$4", name: "$2 "}"}'"
  "gem query --local | awk '{ print "  - name: " $1 }'"
  "npm ll -g --depth 0 | awk '{ print " - name:" $2 }' | tail -n +2"
  "pip list | awk '{ print "- name:"$1 }' | tail -n +3"
)

for p in "${backup_commands[@]}"
do
 $p | tee -a config-helper.yml
done
```