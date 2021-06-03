# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/focal64"
#   config.vm.network :forwarded_port, guest: 3000,  host: 3000    # rails
#   config.vm.network :forwarded_port, guest: 9292,  host: 9292    # rack
#   config.vm.network :forwarded_port, guest: 4567,  host: 4567    # sinatra
#   config.vm.network :forwarded_port, guest: 1080,  host: 1080    # mailcatcher
#   config.vm.network :forwarded_port, guest: 3306,  host: 3306    # mysql
#   config.vm.network :forwarded_port, guest: 1234,  host: 1234    # node
#   config.vm.network :forwarded_port, guest: 5432,  host: 5432    # postgresql
#   config.vm.network :forwarded_port, guest: 6379,  host: 6379    # redis
#   config.vm.network :forwarded_port, guest: 9200,  host: 9200    # elasticsearch
#   config.vm.network :forwarded_port, guest: 27017, host: 27017   # mongodb
#   config.vm.network :forwarded_port, guest: 80,    host: 8080    # apache/nginx

  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
  config.vm.synced_folder "~/workspace", "/workspace", id: "vagrant-repos"

  config.vm.network :private_network, ip: "192.168.10.10"
end
