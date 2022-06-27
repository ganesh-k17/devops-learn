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