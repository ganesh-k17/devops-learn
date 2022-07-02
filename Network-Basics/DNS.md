# DNS:

## How to configure DNS in linux:

* The DNS configurations are available in /etc/hosts file in linux machines.  We have add entries to map DNS configurations (IP address to a Name);

```linux
$ cat >> /etc/hosts
```

add entry as below,

```linux
/etc/hosts:

192.168.1.11 db
192.168.1.11 www.google.com
(<IP_address> <NAME to map>)
```


* We can ping, ssh, or curl to the machine using the DNS Name (Here the name is configured in local and it works only in the machine and it is not global, not working in another machine since this host file is in the local.  Thats why we are using DNS Server)

```linux
$ ping db
$ ssh db
$ curl http://www.google.com
```


## DNS Server:

DNS server is server which will be redirected for the host file to refer DNS names.  This will address the issues in above.  

So we have to map the DNS server name in /etc/resolv.conf in local. 

```linux

$ cat /etc/resolv.conf

nameserver 192.168.1.100

```


So a server can map a DNS name in local or can map a DNS Server to map a DNS name.  DNS name in local host file is the first preference.  So to refer a DNS name first it refer local host name if the dns name is not available then it refer to the DNS server configured.  This order can be modified by doing the changes in /etc/nsswitch.conf file.

```linux
$ cat /etc/nsswitch.conf

...
hosts:   files dns
...
```

here files is local host configuration and dns is dns server configurations.   So here local host file refered first.

Common global well known dns server => 8.8.8.8  (by google) this also can be mapped for DNS configurations.  We can configure multiple DNS servers in /etc/resolv.conf


Others:

nslookup  => used to query a hostname from a DNS server.




