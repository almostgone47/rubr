exec { "yum-update": command => "/usr/bin/yum -y update", timeout => 600}

node default {
  include stdlib
  include epel
  include dev-config
  include ruby2
  include nodejs
  include nginx
  include mysql
  include postgres
}

