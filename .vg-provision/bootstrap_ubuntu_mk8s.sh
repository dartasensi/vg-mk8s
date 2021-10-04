#!/bin/bash

# OS update
sudo apt-get -qq -y update && sudo apt-get -qq -y upgrade

# mk8s official provision
# Instructions found on https://ubuntu.com/kubernetes/install?&_ga=2.265344967.971224718.1633158906-890847867.1633158906#cluster

# Prerequirements: snapd
sudo apt-get -qq -y install snapd

# Install MicroK8s on Linux
sudo snap install microk8s --classic

# MicroK8s creates a group to enable seamless usage of commands which require admin privilege.
# Use the following commands to join the group:
sudo usermod -a -G microk8s vagrant
sudo chown -f -R vagrant ~/.kube
