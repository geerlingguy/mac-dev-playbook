Ansible Playbook - Bottle-MongoDB
=================================

This Ansible playbook provisions a server to act as both a WSGI compliant Bottle webserver and a MongoDB database. Eventually it will have the capabilities of setting up separate servers, one (or multiple) webservers, and one (or multiple) databases. This playbook will also (in the future) be able to be set up bottle using Gevent, a massively multi-threaded synchronous WSGI compliant networking library.

These are the files (bottle, and MogoDB and their dependencies) which are retrieved and installed:

* **python-pip**
* **python-dev**
* **build-essential**
* **MongoDB**