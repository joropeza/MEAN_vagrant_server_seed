# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network "private_network", ip: "10.0.0.10"
  config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.ssh.forward_agent = true

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.options = ['--verbose']
  end

  config.vm.define "ubuntutest" do |ubuntutest|
    ubuntutest.vm.hostname = "ubuntutest.jonny.dance"
    ubuntutest.vm.box = "trusty-server"
    ubuntutest.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
  end
end