# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "hashicorp/bionic64"
  config.env.enable
  config.ssh.password = ENV['GUEST_PASSWORD']
  config.vm.network "forwarded_port", guest: 2456, host: 2456
  config.vm.network "forwarded_port", guest: 2457, host: 2457
  config.vm.network "forwarded_port", guest: 2458, host: 2458
  config.vm.network "public_network", ip: ENV['GUEST_IP']

  # default router
  config.vm.provision "shell",
    run: "always",
    inline: "route add default gw $1",
    args: ENV['GATEWAY_IP']

  # default router ipv6
  # config.vm.provision "shell",
  #   run: "always",
  #   inline: "route -A inet6 add default gw fc00::1 eth1"

  # delete default gw on eth0
  config.vm.provision "shell",
    run: "always",
    inline: "eval `route -n | awk '{ if ($8 ==\"eth0\" && $2 != \"0.0.0.0\") print \"route del default gw \" $2; }'`"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = ENV['VIRTUAL_RAM']
    vb.cpus = ENV['VIRTUAL_CPUS']
  end
end
