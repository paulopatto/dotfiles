# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  

  config.vm.define :fedora do |fedora|
    fedora.vm.box = "fedora/38-cloud-base"
    fedora.vm.hostname = "fedora"
    fedora.vm.synced_folder "./", "/vagrant/dotfiles"

    fedora.vm.provider "virtualbox" do |vb|
      vb.name = "Fedora"
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 1
    end

    fedora.vm.provision :shell, inline: "sudo dnf upgrade -y"
    fedora.vm.provision :shell, inline: "sudo dnf install -y bats"
    fedora.vm.provision :shell, inline: "sudo usermod -a -G sudo vagrant"
    fedora.vm.provision :shell, inline: "cd /vagrant/dotfiles && ./bootstrap"
  end

  config.vm.define :ubuntu do |ubuntu|
    config.vm.box = "ubuntu/jammy64"
    ubuntu.vm.hostname = "ubuntu"
    ubuntu.vm.synced_folder "./", "/vagrant/dotfiles"

    ubuntu.vm.provider "virtualbox" do |vb|
      vb.name = "Ubuntu"
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 1
    end

    ubuntu.vm.provision :shell, inline: "sudo apt upgrade --yes"
    ubuntu.vm.provision :shell, inline: "sudo apt install --yes bats"
    ubuntu.vm.provision :shell, inline: "sudo usermod -a -G sudo vagrant"
    ubuntu.vm.provision :shell, inline: "cd /vagrant/dotfiles && ./bootstrap"
  end
  
  # config.vm.define :macbook do |macbook|
  #   macbook.vm.hostname = "macbook"
  #   macbook.vm.box = "nick-invision/macos-catalina-base"
  # end
end