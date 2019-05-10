#!/bin/bash

# Clear tables and accounting
iptables -F
iptables -X
iptables -Z

#Set default policy
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# copy back resolver config
cp resolv.conf.bak /etc/resolv.conf

# re-configure netowrk cards
ifconfig eno1 up
ifconfig enp3s2 down
