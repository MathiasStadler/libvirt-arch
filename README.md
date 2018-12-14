# insatll arch inside KVM

## sources

```txt
# init article
http://trentsonlinedocs.xyz/stupid_kvm_tricks/


# libvirt archlinux
https://wiki.archlinux.org/index.php/libvirt

# redhat libvirt
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-virsh-delete

# auto install
https://torben.website/archinstall/#home

#archlinux-installer
https://disconnected.systems/blog/archlinux-installer/

#netboot
https://wiki.archlinux.org/index.php/Netboot

#
https://serverfault.com/questions/364895/virsh-vm-console-does-not-show-any-output

# mount imanges nfs
https://serverfault.com/questions/257962/kvm-guest-installed-from-console-but-how-to-get-to-the-guests-console


#
https://www.techotopia.com/index.php/Installing_a_KVM_Guest_OS_from_the_Command-line_(virt-install)

#
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_host_configuration_and_guest_installation_guide/app_pxe_guest_boot_fail

# libvirt include tftp server
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_host_configuration_and_guest_installation_guide/chap-virtualization_host_configuration_and_guest_installation_guide-libvirt_network_booting

# pxe private network
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_host_configuration_and_guest_installation_guide/chap-virtualization_host_configuration_and_guest_installation_guide-libvirt_network_booting-boot_using_pxe-libvirt


```

## list pool

```bash
virsh pool-list --all
```

## list images in pool

```bash
# virsh vol-list poolname
virsh vol-list images-1
```

## delete images

```bash
# virsh vol-delete  --pool poolname volumename
sudo virsh vol-delete --pool images-1 arch.qcow2
```

## delete machine and storage

```bash
sudo virsh undefine guest1 --remove-all-storage
```

## delete all shutdown kvm

```bash
sudo virsh list --all| grep ausschalten| awk '{print $2}'|xargs -I '{}' sudo virsh undefine {} --remove-all-storage
```

## virsh ttyconsole

```bash
sudo virsh ttyconsole arch
```

## boot cmdline

```bash
.linux boot/x86_64/vmlinuz archisobasedir=arch archisolabel=ARCH_201812 initrd=boot/intel_ucode.img,boot/amd_ucode.img,boot/x86_64/archiso.img console=ttyS0
```

## garbage

```bash
679  virsh vol-list
  680  virsh vol-list images
  682  virsh vol-delete --pool images-1 arch.qcow2
  683  sudo virsh virsh vol-dumpxml --pool images-1 arch.qcow2
  686  sudo virsh vol-dumpxml --pool images-1 arch.qcow2
  688  virsh vol-list images-1
  689  sudo virsh vol-list --pool images-1 arch.qcow2
  690  sudo virsh vol-delete --pool images-1 arch.qcow2
  692  virsh pool-destroy images-1
  696  virsh pool-start images-1
  697  virsh pool-undefine images-1
  698  virsh pool-list --all
  699  sudo virsh vol-list --pool images-1 
  700  sudo virsh vol-list --pool images
  701  sudo virsh vol-list --pool trapapa
  

```


virt-install --virt-type kvm --name test8 --memory 2048 --disk path=/var/lib/libvirt/images/test8-1.qcow2,size=5 --disk path=/var/lib/libvirt/images/test8-2.qcow2,size=2 --location /softwarestorage/debian-8.5.0-amd64-CD-1.iso --graphics none 
--extra-args='console tty0 console=ttyS0,115200n8 serial'



sudo virt-install --name centos-vm \
--ram 1024 \
--disk path=/var/lib/libvirt/images/xx.img,size=20 \
--location 127.0.0.1:/var/lib/libvirt/images/ipxe.lkrn \
--os-type linux \
--nographics \
--accelerate \
--extra-args="console=ttyS0"


sudo virt-install --name centos-vm \
--ram 1024 \
--disk path=/var/lib/libvirt/images/xx.img,size=20 \
--location=/mnt/archiso \
--os-type linux \
--nographics \
--accelerate \
--extra-args="console=ttyS0"

sudo virt-install --name centos-vm --ram 1024 --disk path=/home/user/domains/centos-vm --location /home/user/mnt/cdrom --os-type linux --nographics --accelerate --extra-args="console=ttyS0"

nfs:host:/path

sudo virt-install --name centos-vm \
--ram 1024 \
--disk path=/var/lib/libvirt/images/xx.img,size=20 \
--location=nfs:127.0.0.1:/mnt/archiso \
--os-type linux \
--nographics \
--accelerate \
--extra-args="console=ttyS0"


sudo virt-install --name centos-vm \
--ram 1024 \
--disk path=/var/lib/libvirt/images/xx.img,size=20 \
--location http://127.0.0.1/isolinux \
--os-type linux \
--nographics \
--accelerate \
--extra-args="console=ttyS0"

512  sudo virsh list | awk '{print $2}' |xargs -I {} sudo virsh destroy {}
  514  sudo virsh list --all| awk '{print $2}' |xargs -I {} sudo virsh undefine  {} --remove-all-storage
  515  sudo virsh list
  518  sudo virsh destroy vm1
  519  sudo virsh list | awk '{print $2}' |xargs -I {} sudo virsh undefine  {} --remove-all-storage
  520  sudo virsh list --all | awk '{print $2}' |xargs -I {} sudo virsh undefine  {} --remove-all-storage
  521  sudo virsh list --all


## forward delay

```bash
# show all bridge parameter
ip -d link show virbr10
# set 
# **NOT WORK**
sudo ip link set virbr10 type bridge forward_delay 15
# set
sudo brctl setfd virbr10 2
 sudo brctl showstp virbr10

```