#!/bin/sh

# stop graceful all kvm
sudo virsh list | awk '{print $2}' |xargs -I {} sudo virsh destroy {}

# delete all kvm and there storage 
sudo virsh list --all | awk '{print $2}' |xargs -I {} sudo virsh undefine  {} --remove-all-storage
