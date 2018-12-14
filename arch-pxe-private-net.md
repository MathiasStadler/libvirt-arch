# boot via pxe in private net

## the private net is 203.0.113.0/25

## gateway is bridge virbr10

## sources

```txt
https://wiki.archlinux.org/index.php/PXE


# pxe boot
https://eatpeppershothot.blogspot.com/2014/09/rhelcentos-pxe-install-using-dnsmasq.html
https://eatpeppershothot.blogspot.com/2016/02/uefi-and-legacy-bios-pxe-netboot.html

# virsh-install pxe
https://blog.scottlowe.org/2015/05/11/using-pxe-with-virt-install/

# ubuntu pressed sample
https://blog.scottlowe.org/2015/05/20/fully-automated-ubuntu-install/

# many linux version
https://eatpeppershothot.blogspot.com/2016/07/enable-pxe-netboot-in-kvm-guests-for.html

# pxe on z14
https://blog.ubuntu.com/2017/12/20/early-experiences-with-pxe-net-boot-of-kvm-vms-on-ubuntu-for-s390x

# arch PXE boot
https://wiki.libvirt.org/page/PXE_boot_(or_dhcp)_on_guest_failed


# de openstack vnc
https://docs.openstack.org/de/image-guide/virt-install.html

# dnsmasq standalone tftp
https://stelfox.net/blog/2013/12/using-dnsmasq-as-a-standalone-tftp-server/


# ipxe script und ausfuerliche anleitung
https://jpmens.net/2011/07/18/network-booting-machines-over-http/

# set user class
https://www.google.com/search?q=ipxe+User-Class+Option+77%2C+length+4%3A+dnsmasq&btnG=Suche&client=ubuntu&channel=fs


# generated ipxe images
https://rom-o-matic.eu/

# 
https://blog.dachary.org/

```


## preparation on host

```bash
cd /var/lib/libvirt/images
curl -O http://ftp.fau.de/archlinux/iso/2018.12.01/archlinux-2018.12.01-x86_64.iso

sudo mkdir -p /mnt/archiso
sudo mount -o loop,ro archlinux-2018.12.01-x86_64.iso /mnt/archiso

```

## auto mount images

@TODO auto mount images at system start


## dhcp/bootp parameter (number)

```txt
http://www.networksorcery.com/enp/protocol/bootp/options.htm
```

## dnsmasq.conf

```bash
cat /var/lib/dnsmasq/virbr10/dnsmasq.conf
# Only bind to the virtual bridge. This avoids conflicts with other running
# dnsmasq instances.
except-interface=lo
bind-dynamic
interface=virbr10

# If using dnsmasq 2.62 or older, remove "bind-dynamic" and "interface" lines
# and uncomment these lines instead:
#bind-interfaces
#listen-address=203.0.113.88
#listen-address=2001:db8:aa::1

# IPv4 addresses to offer to VMs. This should match the chosen subnet.
dhcp-range=203.0.113.20,203.0.113.200

# Set this to at least the total number of addresses in DHCP-enabled subnets.
dhcp-lease-max=1000

# Assign IPv6 addresses via stateless address autoconfiguration (SLAAC).
dhcp-range=2001:db8:aa::,ra-only

# Assign IPv6 addresses via DHCPv6 instead (requires dnsmasq 2.64 or later).
# Remember to allow all incoming UDP port 546 traffic on the VM.
dhcp-range=2001:db8:aa::1000,2001:db8:aa::1fff
enable-ra
#dhcp-lease-max=5000

# File to write DHCP lease information to.
dhcp-leasefile=/var/lib/dnsmasq/virbr10/leases
# File to read DHCP host information from.
dhcp-hostsfile=/var/lib/dnsmasq/virbr10/hostsfile
# Avoid problems with old or broken clients.
dhcp-no-override
# https://www.redhat.com/archives/libvir-list/2010-March/msg00038.html
strict-order

# tftpd settings from here https://wiki.archlinux.org/index.php/PXE
dhcp-boot=/arch/boot/syslinux/lpxelinux.0
dhcp-option-force=209,boot/syslinux/archiso.cfg
dhcp-option-force=210,/arch/
dhcp-option-force=66,203.0.113.1
enable-tftp
tftp-root=/mnt/archiso

```



## reenable and restart dnsmasq@virbr10.services

```bash
# reread config file
sudo systemctl reenable dnsmasq@virbr10.services
# restart with new config file
sudo systemctl restart dnsmasq@virbr10.services
# status
sudo systemctl status dnsmasq@virbr10.services
```

## log of dnsmasq@virbr10.services

```bash
sudo journalctl -u dnsmasq.service -f
```

## install darkhttpd

```bash
sudo pacman -S  darkhttpd
```

## start darkhttpd

```bash
sudo darkhttpd /mnt/archiso
```

