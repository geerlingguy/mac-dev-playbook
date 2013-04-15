Plans
=====

* Look into using Jinja2 to adhere with DRY principles. If an app comes in a tar archive, have a workflow for extracting apps from those archives, same thing if it comes in a dmg, or a zip.
* Look into the ability to change directories for multiple commands as upposed to having to change directories on each command.
* Ensure generalization of playbooks and assist distribution by replacing hosts and usernames with code that will allow them to be set on run time.
* Consider streamlining playbook creation by specifying the install-type (app, homebrew, pkg, apt, yum) and letting conditional execution pick the correct playbook to run based on that variable. This would allow tools that can be manually installed, or installed through a package management service like homebrew or apt, to have the ability to be installed different ways.
* Ensure that the tool created on top of Ansible has the abiltiy to check the version of installed mac applications, and not reinstall them if they match, unless a user forces an reinstall. Also provide the abiltiy to manipulate default file type handlers.