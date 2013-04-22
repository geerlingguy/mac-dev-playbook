Ansible Playbooks
=================

**The majority of these playbooks have been created to provision Mac development machines. I am going to separate these playbooks into their own separate git repos, or not, depending on how I decide I want them accessible to the configuration managament enhancement tool I'll be building on top of Ansible. Eventually they will be transformed to handle different operating systems and other variables, such as versions.**

Configure servers in a snap with these concise Ansible playbooks!

Current Playbooks:

* **ZeroMQ** - open source high-performance asynchronous messaging library
* **Bottle-MongoDB** - open source lightweight webserver/application and document-oriented database combination

Future Playbooks:

* **MongoDB** - open source document-oriented database system
* **MySQL** - open source relational database system
* **Apache** - open source web server
* **NginX** - open source web server
* **Python** - open source highlevel interpreted programming language
* **Ruby** - open source highlevel interpreted programming language
* **PHP** - open source highlevel interpreted programming language
* **RVM** - open source Ruby version and environment manager

Before running these Ansible playbooks, or any Ansible commands for that matter, it is essential that you have your public SSH keys copied to your server's `~/.ssh/authorized_keys` file. If you decide that this will make life too easy for you, feel free to use the `-k` flag when running `ansible-playbook` (or `ansible` for that matter too), which will tell Ansible to prompt you for your SSH password. The following command will copy your public key from your management computer, to the server:
	
	# Don't space out and forget to ensure that you replace the username and ip/host address with your specific credentials.
	$ scp ~/.ssh/id_rsa.pub username@111.222.333.444:~/.ssh/authorized_keys # You could also perform the same action against your Ansible hosts using the copy module and the **-k** flag to prompt you for your SSH password.

Then all you have to do, as long as you have properly installed Ansible, and have added it's location to your $PATH, is run the following command to confirm that everything is hunky-dory:

	$ ansible all -m ping
	
That should tell you whether Ansible has the ability to contact, and SSH into, the servers that you've added to your Ansible hosts file in `/etc/ansible/hosts`

It's that simple.