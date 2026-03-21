# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "utm/ubuntu-24.04"

  config.vm.provider :utm do |utm|
    utm.name = "cc-dotfiles"
    utm.memory = 4096
    utm.cpus = 2
    utm.directory_share_mode = "virtFS"
    utm.notes = "Campus Code Dotfiles testing VM"
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: "apt-get update && apt-get install -y curl"

  # config.vm.provision "shell", privileged: false, inline: <<-SHELL
  #   cd /vagrant
  #   LOCAL_INSTALL=1 sh install.sh
  # SHELL
end
