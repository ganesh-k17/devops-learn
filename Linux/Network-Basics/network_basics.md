# Network Basics:

* Switching
* Routing
* Default Gateway
* DNS Configurations on Linux

## Switching:

* Switch can connect s/ms within the network.
```bash
$ ip link   # to see interface to connect network and modify it on the host.
$ ip addr   # to check whether a VM is assigned with any ip address.
$ ip addr add 192.168.1.10/24 dev eth0   # to assign system with a IP address
```
## Routing and Gateway

It is for connecting two network and make them communicate

```bash
$ Kernel IP routing table  # to view the route and gateway settings
$ ip route add 192.168.2.0/24 via 192.168.1.1  # to add routing with gateway 192.168.1.1
$ Kernel IP routing table # to view the route and gateway settings.
```

* Routing should be added to all the VMs in the network to connect gateway and communicate with other network.

$ route

```bash
$ cat /proc/sys/net/ipv4/ip_forward  # to check whether IP forwarding is enabled or not (we have to modify it to 1 if it is 0 in the ip_forward file)
```



Now jump host is able to access all four apps. But if you try to ping app03 or app04 from app01 or app02 or vice versa you will see ping is not working. So now we want to use jump host as a router so that app01 and app02 can access app03 and app04 and vice versa, lets add some routing table entries on these hosts to make it work.

a. Add a routing table entry in app01 and app02 hosts so that these hosts can reach app03 and app04 hosts via jump host.

b. Add a routing table entry in app03 and app04 hosts so that these hosts can reach app01 and app02 hosts via jump host.

c. Now try to ping app03 and app04 from app01 and app02 and vice versa, every app should be able to ping each other.



Ans:

Use below mentioned command:

On app01 and app02: sudo ip route add 172.16.239.0/24 via 172.16.238.10

On app03 and app04: sudo ip route add 172.16.238.0/24 via 172.16.239.10


[root@app03 ~]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
9: eth0@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:10:ee:0d brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.16.239.15/24 scope global eth0
       valid_lft forever preferred_lft forever
25: eth1@if26: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:06 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.6/16 brd 172.17.255.255 scope global eth1
       valid_lft forever preferred_lft forever



thor@jump_host ~$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
13: eth0@if14: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:10:ee:0a brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.16.238.10/24 brd 172.16.238.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet 172.16.239.10/24 scope global eth0
       valid_lft forever preferred_lft forever
23: eth1@if24: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:05 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.5/16 brd 172.17.255.255 scope global eth1
       valid_lft forever preferred_lft forever
thor@jump_host ~$ 


thor@jump_host ~$ ssh root@app01
Last login: Thu Jun 30 17:42:36 2022 from jump_host.devops-networking-switching_app_net
[root@app01 ~]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
17: eth0@if18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:10:ee:0b brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.16.238.15/24 scope global eth0
       valid_lft forever preferred_lft forever
29: eth1@if30: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:08 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.8/16 brd 172.17.255.255 scope global eth1
       valid_lft forever preferred_lft forever
[root@app01 ~]# exit
logout
Connection to app01 closed.

thor@jump_host ~$ ssh root@app02
Last login: Thu Jun 30 17:53:30 2022 from jump_host.devops-networking-switching_app_net
[root@app02 ~]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
19: eth0@if20: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:10:ee:0c brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.16.238.16/24 scope global eth0
       valid_lft forever preferred_lft forever
21: eth1@if22: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:04 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.4/16 brd 172.17.255.255 scope global eth1
       valid_lft forever preferred_lft forever
[root@app02 ~]# 