#!/bin/bash

# User Defined Section
TCP_PORTS="80,443,53,22,21"
UDP_PORTS="53,67,68"
ICMP_PORTS=" 0 3 8 "
EXTERNAL_INTERFACE="eno1"
INTERNAL_INTERFACE="enp3s2"
FIREWALL_IP="192.168.10.1"
INTERNAL_IP="192.168.10.2"
FORWARD_IP="192.168.0.8"
UTILITY="/sbin/iptables"


# function to setup firewall interface
function route_firewall {
    echo "Routing Firewall"
    backup_resolver
    ifconfig $INTERNAL_INTERFACE $FIREWALL_IP up
    echo "1" >/proc/sys/net/ipv4/ip_forward
    route add -net 192.168.0.0 netmask 255.255.255.0 gw 192.168.0.100
    route add -net 192.168.10.0/24 gw $FIREWALL_IP
}


# Function to setup clients interface
function route_client {
    echo "Routing internal client"
    backup_resolver
    ifconfig $EXTERNAL_INTERFACE down
    ifconfig $INTERNAL_INTERFACE $INTERNAL_IP up
    route add default gw $FIREWALL_IP
}


# Function to setup firewall rules
function setup_firewall_rules {

    # Clear tables
    $UTILITY -F
    $UTILITY -X
    $UTILITY -Z

    #Set Default Policy
    $UTILITY -P INPUT DROP
    $UTILITY -P FORWARD DROP
    $UTILITY -P OUTPUT DROP

    #DROP PACKETS FROM OUTSIDE FOR FIREWALL
    $UTILITY -A INPUT -i $EXTERNAL_INTERFACE -d $FORWARD_IP -j DROP

    #DROP PACKETS WITH ADRESS FROM OUTSIDE THAT HAS SOURCE ADDRESS OF INTERNAL NETWORK
    $UTILITY -A FORWARD -i $EXTERNAL_INTERFACE -s 192.168.10.0/24 -j DROP

    #DROP TELNET
    $UTILITY -A FORWARD -p TCP --sport 23 -j DROP
    $UTILITY -A FORWARD -p TCP --dport 23 -j DROP

    #DROP SYN AND FYN
    $UTILITY -A FORWARD -p TCP --tcp-flags SYN,FIN SYN,FIN -j DROP

    #DROP FROM PORTS
    $UTILITY -A FORWARD -p TCP --dport 32768:32775 -j DROP
    $UTILITY -A FORWARD -p TCP --dport 137:139 -j DROP
    $UTILITY -A FORWARD -p TCP -m multiport --dport 111,515 -j DROP
    $UTILITY -A FORWARD -p UDP --dport 32768:32775 -j DROP
    $UTILITY -A FORWARD -p UDP --dport 137:139

    #SSH FTP min delay, FTP max throughput
    iptables -A PREROUTING -t mangle -p tcp -m multiport --sport 21,22 -j TOS --set-tos Minimize-Delay
    iptables -A PREROUTING -t mangle -p tcp -m multiport --sport 21 -j TOS --set-tos Maximize-Throughput


    $UTILITY -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    #Allow TCP ports
    $UTILITY -A FORWARD -p TCP -m multiport --dport $TCP_PORTS -j ACCEPT -m state --state NEW,ESTABLISHED
    $UTILITY -A FORWARD -p TCP -m multiport --sport $TCP_PORTS -j ACCEPT -m state --state NEW,ESTABLISHED

    #Allow UDP ports
    $UTILITY -A FORWARD -p UDP -m multiport --dport $UDP_PORTS -j ACCEPT -m state --state NEW,ESTABLISHED
    $UTILITY -A FORWARD -p UDP -m multiport --sport $UDP_PORTS -j ACCEPT -m state --state NEW,ESTABLISHED

    #Allow ICMP
    for p in $ICMP_PORTS;
    do
        $UTILITY -A FORWARD -p icmp --icmp-type $p -j ACCEPT -m state --state NEW,ESTABLISHED
    done

    #Set Routing Rules
    $UTILITY -A POSTROUTING -t nat -j SNAT -s 192.168.10.0/24 -o eno1 --to-source $FORWARD_IP
    $UTILITY -A PREROUTING -t nat -j DNAT -i eno1 --to-destination $INTERNAL_IP
}


# Function to copy resolver config data
function backup_resolver {
    cp /etc/resolv.conf resolv.conf.bak
}


# ---- MAIN ---- #
if [ "$1" == "" ] # if no argument provided
then
    echo "Usage: ./firewall {firewall | client}"
    exit 1
elif [ "$1" = "firewall" ] # set up firewall
then
    route_firewall
    setup_firewall_rules
elif [ "$1" = "client" ] # setup client
then
    route_client
else
    echo "Error: invalid argument provided"
fi
