#!/bin/sh
#qemu-full or qemu-base for version without GUI
sudo pacman -S qemu-full libvirt virt-manager dnsmasq edk2-ovmf

sudo usermod -a -G libvirt ramon

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
