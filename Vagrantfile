# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # #####
  # configuration variables
  # #####
  # ubuntu 20.10
  _vm_box = "ubuntu/groovy64"
  _vm_name = "vg-ubuntu20.10-mk8s"
  _vm_hostname = "main.example.com"

  # #####
  # vagrant vm definition
  # #####
  config.vm.box = _vm_box

  # vbguest: Should the plugin take the Guest Additions from remote or local installation? (default: remote)
  #config.vbguest.no_remote = true
  # vbguest: Allow the plugin to upgrade the kernel before installing (requires reboot)
  config.vbguest.installer_options = { allow_kernel_upgrade: true }

  config.vm.define "main", primary: true do |main|
    main.vm.hostname = _vm_hostname

    # use the default sync folder /vagrant
    main.vm.synced_folder ".", "/vagrant", automount: true, disabled: false

    ## check and exec only if plugin are not disabled
    #if Vagrant.has_plugin?("vagrant-vbguest")
    #  # custom shared folder
    #  main.vm.synced_folder _sharedFolder_provision_hostPath, _sharedFolder_provision_guestPath, create: true
    #  main.vm.synced_folder _sharedFolder_vboxsf_hostPath, _sharedFolder_vboxsf_guestPath, create: true
    #end

    # inside the guest vm, it should offer a balancer on port 80
    main.vm.network "forwarded_port", host: 10080, guest: 80, auto_correct: true

    # only for debug purposes
    main.vm.network "forwarded_port", host: 15432, guest: 5432, auto_correct: true
    main.vm.network "forwarded_port", host: 18080, guest: 8080, auto_correct: true
    main.vm.network "forwarded_port", host: 18081, guest: 8081, auto_correct: true
    main.vm.network "forwarded_port", host: 18082, guest: 8082, auto_correct: true
    main.vm.network "forwarded_port", host: 18083, guest: 8083, auto_correct: true
    main.vm.network "forwarded_port", host: 18084, guest: 8084, auto_correct: true
    main.vm.network "forwarded_port", host: 18085, guest: 8085, auto_correct: true

    main.vm.provider :virtualbox do |vb|
      vb.name = _vm_name
      # low perf settings
      #vb.cpus = 2
      #vb.memory = "4096"
      # high perf settings
      vb.cpus = 4
      vb.memory = "8192"

      # try to use VirtualBox linked clone
      vb.linked_clone = true

      # ubuntu: with this distro, it can not set the host as dns resolver, it breaks the dns resolver of docker containers
      #vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      #vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

      # enable the clipboard/draganddrop as bidirectional
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]

      ## Display the VirtualBox GUI when booting the machine
      #vb.gui = false

      # to apply when VBox > 6.1.14: set the display settings for VRAM, VMSVGA and 3D acceleration
      vb.customize ["modifyvm", :id, "--vram", "16"]
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
      vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    end


    # inline basic provision: update
    main.vm.provision "Update OS", privileged: true, type: "shell", inline: "sudo apt-get -qq -y update && sudo apt-get -qq -y upgrade"
    # custom script for utils provision
    main.vm.provision :shell, path: ".vg-provision/bootstrap_ubuntu_utils.sh"
    # custom script for mk8s provision
    # ref. https://ubuntu.com/kubernetes/install?&_ga=2.265344967.971224718.1633158906-890847867.1633158906#cluster
    main.vm.provision :shell, path: ".vg-provision/bootstrap_ubuntu_mk8s.sh"

    # reload: use the plugin to reboot
    #main.vm.provision :reload
  end
end
