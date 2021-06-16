# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
  config.vm.synced_folder "~/workspace", "/workspace", id: "vagrant-repos"

  config.vm.network :private_network, ip: "192.168.10.10"
end
