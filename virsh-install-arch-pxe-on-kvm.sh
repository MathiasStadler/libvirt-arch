#!/bin/sh

if [ -z "$1" ] ;
then
 echo Specify a virtual-machine name.
 exit 1
fi

sudo virt-install \
--pxe \
--name $1 \
--ram 4096 \
--disk path=/var/lib/libvirt/images/$1.img,size=20,bus=virtio \
--vcpus 2 \
--os-type linux \
--os-variant ubuntu16.04 \
--network bridge=virbr10,model=virtio \
--noautoconsole --graphics=vnc \

