# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64" #ubuntu-16.04-amd64"

  config.vm.hostname = "gitlab.example.com"

  config.vm.network "private_network", ip: "192.168.33.20"

  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = true
    #vb.gui = true
    vb.memory = "4096"
  end

  config.vm.provision "shell", path: "provision.sh"
  config.vm.provision "dapp", type: "shell", path: "docker-and-dapp.sh"
end
