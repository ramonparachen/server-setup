#!/bin/sh

#Firewall {{{
echo "flush ruleset" >> /etc/nftables.conf
echo "table inet firewall {" >> /etc/nftables.conf
echo "	chain inbound_ipv4 {" >> /etc/nftables.conf
echo "		#icmp type echo-request limit rate 5/second accept" >> /etc/nftables.conf
echo "	}" >> /etc/nftables.conf
echo "	chain inbound_ipv6 {" >> /etc/nftables.conf
echo "		icmpv6 type { nd-neighbor-solicit, nd-router-advert } accept" >> /etc/nftables.conf
echo "		#icmp type echo-request limit rate 5/second accept" >> /etc/nftables.conf
echo "	}" >> /etc/nftables.conf
echo "	chain inbound {" >> /etc/nftables.conf
echo "		type filter hook input priority 0; policy drop;" >> /etc/nftables.conf
echo "		ct state vmap { established : accept, related : accept, invalid : drop }" >> /etc/nftables.conf
echo "		iifname lo accept" >> /etc/nftables.conf
echo "		meta protocol vmap { ip : jump inbound_ipv4, ip6 : jump inbound_ipv6 }" >> /etc/nftables.conf
echo "		tcp dport { 53, 80, 8080, 443 } accept" >> /etc/nftables.conf
echo "		udp dport { 53, 80, 8080, 443 } accept" >> /etc/nftables.conf
echo "	}" >> /etc/nftables.conf
echo "	chain forward {" >> /etc/nftables.conf
echo "		type filter hook forward priority 0; policy drop;" >> /etc/nftables.conf
echo "	}" >> /etc/nftables.conf
echo "}" >> /etc/nftables.conf

sudo systemctl enable nftables.service
#}}}

#DNS {{{
sudo apt-get -y install dnsmasq
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.original

echo "domain-needed" >> /etc/dnsmasq.conf
echo "bogus-priv" >> /etc/dnsmasq.conf
echo "no-resolv" >> /etc/dnsmasq.conf
echo "expand-hosts" >> /etc/dnsmasq.conf
echo "domain=casa.net" >> /etc/dnsmasq.conf
echo "local=/casa.net/" >> /etc/dnsmasq.conf
echo "listen-address=127.0.0.1,192.168.15.201" >> /etc/dnsmasq.conf
echo "" >> /etc/dnsmasq.conf
echo "server=192.168.15.1" >> /etc/dnsmasq.conf
#}}}

#Docker {{{
sudo apt-get -y install curl
curl -fsSL get.docker.com | sudo sh
#}}}

#Nextcloud container {{{
sudo docker run --sig-proxy=false --name nextcloud-aio-mastercontainer --restart always --publish 80:80 --publish 8080:8080 --publish 8443:8443 --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config --volume /var/run/docker.sock:/var/run/docker.sock:ro nextcloud/all-in-one:latest
#}}}
