# IP Address:

* is assigned to interface (machine/laptop)

* Option for assign network
	* Host Only Network (can't connect outside network)
	* NAT Network (using network address traslation to connect outside network (the VM's n/ws are connecting the outside network via PC n/w, so the outside network could not connect the VM's (it can only have access to the PC.)))
	* Bridge network
	


# Networking options (virtual box VM)

NAT:

Default adapter.

Bridge Adapter:

# NAT vs NAT Network


# If IP address is not found in VM by installing VM in virtual box(using ip addr show)

In my case, I installed two CentOS virtual machine by using VMware Player (Host OS: CentOS7). I found no IP address for both of virtual machines. The IP address set by following the below procedures.

Check the current connection on your VM:

## nmcli con show
NAME      UUID     TYPE      DEVICE
ens33     xxxxxx   ethernet  ---

The network is not activated yet after virtual machine installation.

Lets, activate the network connection by using this command:

## nmcli con up ens33
Connection successfully activated xxxxxxx
Check whether the newly activated network is ready:

## nmcli con show
NAME        UUID        TYPE        DEVICE
ens33       xxxxxx      ethernet    ens33
Now check your IP address on CentOS virtual machine:

## ip address show | grep inet
inet 127.0.0.1/8 scope host lo
inet6 ::1/128 scope host
inet 192.168.xxx.xxx/xx brd 192.168.xxx.xxx scope global noprefixroute dynamic ens33
inet6 xxxxxxx
Your IP address for the CentOS virtual machine is : 192.168.xxx.xxx/xx


# Network manager troubleshoot

To check Network manager status (whether enabled or not!)
$ systemctl status NetworkManager

To enable Network manager
$ systemctl enable NetworkManager

To restart Network manager
$ sudo systemctl restart NetworkManager


