class ruby2::prereq {
	package {["libxslt-devel", "libxml2-devel", "libyaml-devel", "vim-enhanced", "tmux", "qt-devel", "qt", "geos-devel"]:
		ensure => "installed",
		require => Exec['yum-update'];
	}
}

class ruby2::install-rvm {
	include rvm
	rvm::system_user {
		vagrant:
		require => Class['ruby2::prereq']; 
	}
}

class ruby2::install {
	rvm_system_ruby { 'ruby-2.2':
		ensure => 'present',
		require => Class['ruby2::install-rvm'];
	}
}

class ruby2::fix-permissions {
	exec { 'fix_rvm_permissions':
		command => '/bin/chmod -R 775 /usr/local/rvm ; /bin/chown -R :rvm /usr/local/rvm',
		require => Class['ruby2::install'];
	}
}

class ruby2 {
	include ruby2::prereq, ruby2::install-rvm, ruby2::install, ruby2::fix-permissions
}
