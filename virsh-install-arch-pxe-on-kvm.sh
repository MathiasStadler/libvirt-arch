sudo virt-install --name arch-pxe --ram 4096 \
--disk path=/var/lib/libvirt/images/arch-pxe.qcow2,size=20 \
--vcpus 2 \
--os-type linux \
--os-variant ubuntu16.04 \
--network bridge=virbr10 \
--graphics none \
--console pty,target_type=serial \
--cdrom /var/lib/libvirt/images/ipxe.lkrn
