# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  config.vm.define "ubuntu-ssl" do |config|
  config.vm.hostname = "ubuntu-ssl"
  config.vm.box = "ubuntu/xenial64"
  config.vm.network :forwarded_port, guest: 8000, host: 8000
  config.vm.network :forwarded_port, guest: 4443, host: 4443

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ubuntu-ssl"
  end

  config.vm.synced_folder "./ssl_tools", "/ssl_tools/"

  # Provision
  config.vm.provision "shell", inline: "sudo apt-get update"
  config.vm.provision "shell", inline: "sudo apt-get upgrade -y"
  config.vm.provision "shell", inline: "sudo add-apt-repository -y 'ppa:git-core/ppa'"
  config.vm.provision "shell", inline: "sudo add-apt-repository -y 'ppa:deadsnakes/ppa'"
  config.vm.provision "shell", inline: "sudo apt-get update"
  config.vm.provision "shell", inline: "apt-get install -y python-pip  python3-psycopg2 python3.6 python3.6-dev python3.6-venv python-minimal git build-essential libffi-dev libpq-dev libssl-dev libxml2-dev libxslt1-dev"
  end
end
