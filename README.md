# insatll arch inside KVM

## sources

```txt
# init article
http://trentsonlinedocs.xyz/stupid_kvm_tricks/


# libvirt archlinux
https://wiki.archlinux.org/index.php/libvirt

# rehat libvirt
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-virsh-delete

# auto install
https://torben.website/archinstall/#home

#archlinux-installer
https://disconnected.systems/blog/archlinux-installer/

#netboot
https://wiki.archlinux.org/index.php/Netboot

#
https://serverfault.com/questions/364895/virsh-vm-console-does-not-show-any-output

```

## list pool

```bash
virsh pool-list --all
```

## list images in pool

```bash
# virsh vol-list           poolname
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