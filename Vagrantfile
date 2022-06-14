# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.vm.box = "reclusive/bionic64-docker"
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  #config.vm.synced_folder ".", "/project"

  config.vm.define "Ubuntu_18_test" do |ubuntu|
    ubuntu.ssh.private_key_path = ["C:/Users/Alexander/.vagrant.d/20170926_vagrant_private_key"]
    #ubuntu.ssh.private_key_path = "~/.vagrant.d/20170926_vagrant_private_key"
    ubuntu.vm.network "private_network", ip: "192.168.33.18"
    ubuntu.vm.box = "reclusive/xenial64-docker"
    ubuntu.vm.box_check_update = true
    ubuntu.vm.provision "shell", run:"always", inline: <<-'SHELL'
        #!/usr/bin/env bash
        sudo echo "192.168.2.5 registry.alexanderhopgood.com" | sudo tee -a /etc/hosts
        sudo touch /etc/docker/daemon.json
        sudo printf "%s" "{ \"insecure-registries\":[\"registry.alexanderhopgood.com:5000\"]}" | sudo tee -a /etc/docker/daemon.json
        sudo systemctl restart docker

        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        sudo apt-get update && sudo apt-get install -y nomad unzip

        LEVANT_VERSION="0.3.0"
        curl -L -o levant-${LEVANT_VERSION}.zip https://releases.hashicorp.com/levant/${LEVANT_VERSION}/levant_${LEVANT_VERSION}_linux_amd64.zip
        sudo unzip levant-${LEVANT_VERSION}.zip -d /usr/bin

    SHELL
  end
end
