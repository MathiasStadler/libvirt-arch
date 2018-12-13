#!/bin/sh

if [ -z "$1" ] ;
then
 echo Specify a virtual-machine name.
 exit 1
fi

sudo virt-install \
--name $1 \
--pxe \
--disk path=/var/lib/libvirt/images/$1.img,size=30 \
--vcpus 2 \
--ram 4096 \
--os-type linux \
--os-variant ubuntu16.04 \
--network bridge=virbr10 \
--graphics none \
--noautoconsole \
--hvm \
--debug
