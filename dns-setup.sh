#!/bin/sh
sudo apt install dnsmasq
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.original

echo "domain-needed" >> /etc/dnsmasq.conf
echo "bogus-priv" >> /etc/dnsmasq.conf
echo "no-resolv" >> /etc/dnsmasq.conf
echo "expand-hosts" >> /etc/dnsmasq.conf
echo "domain=.casa.net" >> /etc/dnsmasq.conf
echo "local=/.casa.net/" >> /etc/dnsmasq.conf
echo "listen-address=127.0.0.1" >> /etc/dnsmasq.conf
echo "" >> /etc/dnsmasq.conf
echo "server=192.168.15.1" >> /etc/dnsmasq.conf
