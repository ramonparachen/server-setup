#!/bin/sh
sudo apt update && sudo apt install iptables

sudo iptables -N TCP
sudo iptables -N UDP

sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD DROP

sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
sudo iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP
sudo iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
sudo iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
sudo iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

#DNS
sudo iptables -A TCP -p tcp --dport 53 -j ACCEPT
sudo iptables -A UDP -p udp --dport 53 -j ACCEPT
#HTTPS
sudo iptables -A TCP -p tcp --dport 443 -j ACCEPT
sudo iptables -A UDP -p udp --dport 443 -j ACCEPT
#HTTP
sudo iptables -A TCP -p tcp --dport 80 -j ACCEPT
sudo iptables -A UDP -p udp --dport 80  -j ACCEPT
sudo iptables -A TCP -p tcp --dport 8080 -j ACCEPT
sudo iptables -A UDP -p udp --dport 8080 -j ACCEPT
sudo iptables -A TCP -p tcp --dport 8443 -j ACCEPT
sudo iptables -A UDP -p udp --dport 8443 -j ACCEPT

sudo mkdir /etc/iptables
sudo iptables-save -f /etc/iptables/iptables.rules
sudo iptables-save -f /etc/iptables/ip6tables.rules
