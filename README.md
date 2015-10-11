# Rubr

## Requirements
- Ruby - ruby-2.2.1
- RVM - 1.26.2
- Rails - 4.2.1
- Vagrant - 1.6.5
- VirtualBox - 4.3.18
- Bundler

## Installation
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
