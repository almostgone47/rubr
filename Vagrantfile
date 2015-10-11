Vagrant.configure("2") do |config|
	config.vm.provider "virtualbox" do |v|
		v.customize ["modifyvm", :id, "--memory", "2048"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
	end

  config.vm.network :private_network, ip: "192.168.50.14"
end

Vagrant::Config.run do |config|
  config.vm.share_folder "/vagrant", "/vagrant", "./", :nfs => true
	config.vm.box = "centos"
	config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"
	config.ssh.forward_agent = true
	config.vm.provision :puppet do |puppet|
		puppet.manifests_path 	= "puppet"
		puppet.module_path 			= "puppet/modules"
		puppet.manifest_file 		= "default.pp"
		puppet.options 					= "--verbose --debug"
	end
end

