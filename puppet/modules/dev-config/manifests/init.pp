class dev-config::iptables {
	file { '/etc/sysconfig/iptables':
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => '0600',
		source  => '/vagrant/puppet/modules/dev-config/templates/iptables';
	}
}

class dev-config {
	include dev-config::iptables
}
