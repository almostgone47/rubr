# Rubr

Rubr is a Tinder "clone" written in Ruby using Rails. It uses fake accounts to demonstrate its functionality.

Warning: Due to fake accounts taking random images from Imgur, sometimes the pictures won't be work appropriate. You have been warned.

## Requirements
- Ruby - ruby-2.2.1
- RVM - 1.26.2
- Rails - 4.2.1
- Vagrant - 1.6.5
- VirtualBox - 4.3.18
- Bundler

# Installation

## Setting up VirtualBox
- `vagrant up`
- `vagrant ssh`
- `command curl -sSL https://rvm.io/mpapis.asc | sudo gpg2 --import -`
- `exit`
- `vagrant provision`
- `vagrant provision`
- `vagrant provision`
- `vagrant ssh`
- `sudo service iptables stop`
- `sudo chkconfig iptables off`
- `sudo yum install memcached`
- `sudo chkconfig memcached on`
- `sudo service memcached start`
- `cd /vagrant`
  - note: you can update `.bash_profile` file to set rvm && cd/vagrant
- `rvm alias create default ruby-2.2.1`
- `rvm use ruby-2.2.1`
- `sudo gem install bundle`
  - note: This may not always be necessary, use this if you get "bundle not a recognized command" or similar
- `bundle`
- `sudo service postgresql-9.3 start`
- `sudo chkconfig postgresql-9.3 on`
- `sudo su - postgres`
- `createuser vagrant --pwprompt`
  - hit enter to leave the password blank
- `psql`
- `create database rubr_development;`
  - hit ctrl + D twice
- `rake db:migrate`
- `rake create_fake_accounts[50]`

## Setting up Python
- sudo yum install python-pip
- sudo pip install cleverbot
- (You can install virtualenv and all of that if you're really motivated. I wasn't.)


## Starting
- python lib/cleverbot_api/main.py
- puma -p 8080
- rake keep_responding_to_messages
- rake trickle_new_accounts
