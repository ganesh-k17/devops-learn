# Firewall

A firewall is a way to protect machines from any unwanted traffic from outside. It
enables users to control incoming network traffic on host machines by defining a set of
firewall rules. These rules are used to sort the incoming traffic and either block it
or allow through.

## [Firewalld](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/using-and-configuring-firewalld_configuring-and-managing-networking)

firewalld is a firewall service daemon that provides a dynamic customizable host-based
firewall with a D-Bus interface. Being dynamic, it enables creating, changing, and
deleting the rules without the necessity to restart the firewall daemon each time the
rules are changed.

firewalld uses the concepts of zones and services, that simplify the traffic management.
Zones are predefined sets of rules. Network interfaces and sources can be assigned to a zone.
The traffic allowed depends on the network your computer is connected to and the security level
this network is assigned. Firewall services are predefined rules that cover all necessary settings
to allow incoming traffic for a specific service and they apply within a zone.

Services use one or more ports or addresses for network communication. Firewalls filter
communication based on ports. To allow network traffic for a service, its ports must be open.
firewalld blocks all traffic on ports that are not explicitly set as open. Some zones, such as
trusted, allow all traffic by default.

## Utilities

* <b>firewalld</b>: Use the firewalld utility for simple firewall use cases. The utility is easy to use and covers the typical use cases for these scenarios.

* <b>nftables</b>: Use the nftables utility to set up complex and performance critical firewalls, such as for a whole network.

* <b>iptables</b>: The iptables utility on Red Hat Enterprise Linux uses the nf_tables kernel API instead of the legacy back end. The nf_tables API provides backward compatibility so that scripts that use iptables commands still work on Red Hat Enterprise Linux. For new firewall scripts, Red Hat recommends to use nftables.

## Starting firewalld

To start firewalld, enter the following command as root:

```bash
systemctl unmask firewalld
systemctl start firewalld
```

To ensure firewalld starts automatically at system start, enter the following command as root:

```bash
# systemctl enable firewalld
```

## Stopping firewalld

To stop firewalld, enter the following command as root:

```bash
systemctl stop firewalld
```

To prevent firewalld from starting automatically at system start:

```bash
systemctl disable firewalld
```

To make sure firewalld is not started by accessing the firewalld D-Bus interface and also if other services require firewalld:

```bash
systemctl mask firewalld
```