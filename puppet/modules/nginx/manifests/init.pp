class nginx::install {

	package { "nginx-packages":
		name => ["nginx"],
		ensure => installed
	}

}

class nginx::config {
	file {
		'/etc/init/nginx.conf':
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		source  => '/vagrant/puppet/modules/nginx/templates/nginx-init.conf',
		require => Class['nginx::install']
	}

	file {
    	'/etc/nginx/sites-enabled/':
    	ensure  => directory,
    	owner   => 'nginx',
    	group   => 'nginx',
    	mode    => '0755',
    	require => Class['nginx::install']
    }

	file {
    	'/etc/nginx/sites-enabled/rubr':
    	ensure  => present,
    	owner   => 'root',
    	group   => 'root',
    	mode    => '0755',
    	source  => '/vagrant/puppet/modules/nginx/files/rubr',
    	require => Class['nginx::install']
    }

	file {
    	'/etc/nginx/nginx.conf':
    	ensure  => present,
    	owner   => 'nginx',
    	group   => 'nginx',
    	mode    => '0755',
    	source  => '/vagrant/puppet/modules/nginx/files/nginx.conf',
    	require => Class['nginx::install']
    }

}

class nginx::run {
	service { 'nginx':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		#subscribe  => File['/etc/nginx/nginx.conf'],
		require    => Class['nginx::config']
	}

}

class nginx{
    include nginx::install, nginx::config, nginx::run
}


