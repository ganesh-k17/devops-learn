# IPs and Ports

* What IP Address and Port should I use?
* localhost vs 127.0.0.1 vs IP Address
* Why can't I connect to my server

## IP Address

* Whenever we connect with a LAN or wifi adapter we get assigned with IP address for each adapter.  Ip address is asingned to interface.
* Each of these network interface cards are divided into multiple logical multiple logical components called ports.
* We can have upto 65,535 ports and each port is a communication end point.  Progarams can listen on these port for requests.
* So, when we run a web server, it listens for requests on these interfaces on one of these ports.  ex: Python flask listen 5000 port by default and we can modify the port.

## Commands:

```bash
ip addr show  # it would show all the ip addresss assigned to the system.  Lan, wifi, etc.
```

Loop back address - 127.0.0.1  => if the application is not specified  any host then it listens on 127.0.0.1 as host address and the specified port in the app.  Or we can call it as localhost.
