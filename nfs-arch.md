# arch nfs

## motivation provide images for libvirt virsh-install via flag --location

## sources

```txt
# nfs sources
https://wiki.archlinux.de/title/Network_File_System

# mount imanges nfs
https://serverfault.com/questions/257962/kvm-guest-installed-from-console-but-how-to-get-to-the-guests-console
```

## install nfs

```bash
sudo pacman -S nfs-utils
```

## mount images

```bash
# create mount point
sudo mkdir -p /mnt/ipxe
# mount image
sudo mount -o loop,unhide -t iso9660 -r /var/lib/libvirt/images/ipxe.lkrn /mnt/ipxe
```

## set /etc/exports

```bash
ETC_EXPORTS="/etc/exports"
cat << EOF | sudo tee --append $ETC_EXPORTS
/var/lib/libvirt/images    *(ro,insecure,all_squash)
EOF
```

## enable service nfs

```bash
# enable service
sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
# start service
sudo systemctl start rpcbind
sudo systemctl start nfs-server
# status
sudo systemctl status rpcbind
sudo systemctl status nfs-server
```

## refresh nfs

```bash
sudo exportfs -r
```

## show nfs mount

```bash
# showmount -e remote_nfs_server
# e.g.
showmount -e manjaro
# localhost
showmount -e 127.0.0.1
```

## test nfs server ready

```bash
# nfs version 2
rpcinfo -t 127.0.0.1 mountd 2
# output
    program 100005 version 2 ready and waiting

# nfs version 3
rpcinfo -t 127.0.0.1 mountd 3                                                         # output
    program 100005 version 3 ready and waiting
```


