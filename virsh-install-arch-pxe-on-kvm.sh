#!/bin/sh

if [ -z "$1" ] ;
then
 echo Specify a virtual-machine name.
 exit 1
fi

sudo virt-install \
--name $1 \
--ram 4096 \
--disk path=/var/lib/libvirt/images/$1.img,size=20 \
--vcpus 2 \
--os-type linux \
--os-variant ubuntu16.04 \
--network bridge=virbr10 \
--graphics none \
--console pty,target_type=serial \
--cdrom /var/lib/libvirt/images/ipxe.lkrn