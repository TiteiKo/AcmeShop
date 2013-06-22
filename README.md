symfony2-vagrant
================

A template repository for vagrant enabled symfony2 projects.

The VM is a Debian 7.0 (Wheezy) and ships with:

* php 5.4 (fpm + cli)
* mysql
* nginx
* rabbitmq
* git
* redis

And with the following configuration:

* public ip: `192.168.56.101`
* nginx vhost for symfony2 (pointing to `/vagrant/www/`)
* mysql root password: `passroot`
* php's configuration should be mostly ok for dev use

Also, if you have the [hostmanager vagrant plugin](https://github.com/smdahlen/vagrant-hostmanager) installed, it will make use of it and add a `symfony` host to your `/etc/hosts` (meaning you can access your wm through `http://symfony/`).
