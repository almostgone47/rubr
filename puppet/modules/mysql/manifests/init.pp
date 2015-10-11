class mysql::install {

	package { "mysql-packages":
		name => ["mysql-server", "mysql-devel"],
		ensure => latest
	}

}

class mysql::run {
    	service { 'mysqld':
    		ensure     => running,
    		enable     => true,
    		hasrestart => true,
    		hasstatus  => true,
    		require    => Class['mysql::install']
    	}
}

class mysql{
    include mysql::install, mysql::run
}

