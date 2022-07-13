# Apache Web server:

* Opensource
* Web Server

usually used to serve web content and it can be used as application server as it can be used to run some backend services.

## Install:

```bash
yum install httpd       # install httpd apache web server

service httpd start     # to start the server

service http status     # to get the status of the server

firewall-cmd --permanent --add-service=http   # to add firewall rule to allow if firewall configured.

service httpd restart   # restart the server

```

## Default Port:

80 is the default port.

Default page: https://localhost:80

## View logs

```bash
cat /var/log/httpd/access_log  # to view the access log.  Whenever user access the sites.

cat /var/log/httpd/error_log   # to view the error log
```

## Config File

```bash
/etc/httpd/conf/httpd.conf

Options:

Listen  80    # port can be modified.
DocumentRoot  "/var/www/html"   # denfines the contents are stored.
ServerName www.houses.com:80  # server name for the site.  the site can be access through the name.  We should have the DNS configurations (/etc/hosts file) as well to work this.

```

A single apache server can multiple web sites, using VirtualHost as below in the config file

```config
<VirtualHost *:80>
    ServerName www.houses.com
    DocumentRoot /var/www/houses
</VirtualHost>
<VirtualHost>
    ServerName www.oranges.com
    DocumentRoot /var/www/oranges
</VirtualHost>

# in /etc/hosts

127.0.0.1 localhost
127.0.0.1 www.houses.com
127.0.0.1 www.oranges.com

Apache server automaticall pick the site based on the config file though same ip addresses are mapped with two sites in hosts file (or DNS server!)

```


We can split the configuration files as for the various site using the Include option in the Config file.

```bash
Include conf/houses.conf
Include conf/oranges.conf
```

## Others:

```bash
$ cp -R <source_folder>/* <destination_folder>  ## to copy fiesl from a folder to another folder in linux
```