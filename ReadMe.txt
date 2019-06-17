Linux_Firewall_2
----------------

A more advanced IPTables Linux firewall script developed with bash.

The characteristics of the firewall is as follows:

  > Set the initial default policies.

  > Set firewall requirements:
    - Inbound/Outbound TCP packets on allowed ports
    - Inbound/Outbound UDP packets on allowed ports
    - Inbound/Outbound ICMP packets based on type numbers
    - All packets that fall through to the default rule will be dropped
    - Drop all packets destined for the firewall host from the outside
    - Do not accept any packets with a source address from the outside matching your
      internal network
    - You must ensure the you reject those connections that are coming the “wrong” way (i.e., inbound SYN packets to high ports)
    - Accept fragments
    - Accept all TCP packets that belong to an existing connection (on allowed ports)
    - Drop all TCP packets with the SYN and FIN bit set
    - Do not allow Telnet packets at all
    - Block all external traffic directed to ports 32768 – 32775, 137 – 139, TCP ports 111 and 515
    - For FTP and SSH services, set control connections to "Minimum Delay" and FTP data to "Maximum Throughput"

  > Only allow NEW and ESTABLISHED traffic to go through the firewall. In other words you are doing stateful filtering

  > Include a user defined section which includes the following:
    - Name and location of the utility you are using to implement the firewall
    - Internal network address space and the network device
    - Outside address space and the network device
    - TCP services that will be allowed
    - UDP services that will be allowed
    - ICMP services that will be allowed

Please read the Design Doc for further details.