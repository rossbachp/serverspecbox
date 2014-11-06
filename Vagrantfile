# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define "serverspecbox", primary: true do |s|

    s.vm.synced_folder "presentation", "/mnt/presentation"

    s.vm.network "forwarded_port", guest: 8000, host: 8000
    s.vm.network "forwarded_port", guest: 8001, host: 8001
    s.vm.network "private_network", ip: "192.168.50.8"
    s.vm.host_name = "serverspecbox.example.com"
    s.vm.provider 'virtualbox' do |vb|
      vb.gui = false
      vb.customize [ 'modifyvm', :id, '--nicpromisc2', 'allow-all']
      vb.customize [ 'modifyvm', :id, '--memory', '1024']
      vb.customize [ 'modifyvm', :id, '--cpus', '2']
      vb.name = 'serverspecbox'
    end

    s.vm.provision "shell", path: 'provision.d/01_packages.shprov'
    s.vm.provision "shell", path: 'provision.d/10_docker.shprov'
    s.vm.provision "shell", path: 'provision.d/15_docker_prepare_image.shprov'
    s.vm.provision "shell", path: 'provision.d/16_docker_tools.shprov'
    s.vm.provision "shell", path: 'provision.d/40_serverspec.shprov'
  end
end
