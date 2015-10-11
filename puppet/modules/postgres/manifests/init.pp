class postgres::install {
  yumrepo { "pgdg93":
    baseurl => "http://yum.postgresql.org/9.3/redhat/rhel-\$releasever-\$basearch",
    descr => "PostgreSQL 9.3 \$releasever - \$basearch",
    enabled => 1,
    gpgcheck => 0,
  }

  yumrepo { "pgdg93-source":
    baseurl => "http://yum.postgresql.org/srpms/9.3/redhat/rhel-\$releasever-\$basearch",
    descr => "PostgreSQL 9.3 \$releasever - \$basearch - source",
    enabled => 0,
    gpgcheck => 0,
    failovermethod => "priority",
  }

  package { "postgresql93-server": ensure => installed, require => [Yumrepo["pgdg93"], Yumrepo["pgdg93-source"]] }
  package { "postgresql93-devel": ensure => installed, require => [Yumrepo["pgdg93"], Yumrepo["pgdg93-source"]] }

  exec { "create-user":
    command => "/bin/su postgres -c '/usr/pgsql-9.3/bin/createuser --superuser deploy' || true",
  }

  exec { "init-db":
    command => "/sbin/service postgresql-9.3 initdb",
    require => Package["postgresql93-server"],
    unless => "/bin/su postgres -c '/usr/pgsql-9.3/bin/pg_ctl status -D /var/lib/pgsql/9.3/data'",
  }
  
  Service["postgresql-9.3"] {
    start   => "/sbin/service postgresql-9.3 start",
    status  => "/sbin/service postgresql-9.3 status",
    stop    => "/sbin/service postgresql-9.3 stop",
    restart => "/sbin/service postgresql-9.3 restart",
  }
  
  service { "postgresql-9.3":
    ensure => running,
    require => [Exec["create-user"], Exec["init-db"]],
  }
  
  file {"/usr/bin/pg_config":
    ensure => "/usr/pgsql-9.3/bin/pg_config"
  }
  
  file {"/usr/bin/psql":
    ensure => "/usr/pgsql-9.3/bin/psql"
  }

  file {"/usr/bin/pg_dump":
    ensure => "/usr/pgsql-9.3/bin/pg_dump"
  }

  file {"/usr/bin/pg_ctl":
    ensure => "/usr/pgsql-9.3/bin/pg_ctl"
  }

  file {"/usr/bin/createuser":
    ensure => "/usr/pgsql-9.3/bin/createuser"
  }

  file {"/usr/bin/createdb":
    ensure => "/usr/pgsql-9.3/bin/createdb"
  }
  
  user { "postgres":
    ensure => present,
    require => Package["postgresql93-server"],
  }
  

}

class postgres {
  include postgres::install
}
