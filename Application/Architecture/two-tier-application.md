
## Two-Tier Database Architecture –
In two-tier, the application logic is either buried inside the User Interface on the client or within the database on the server (or both). With two-tier client/server architectures, the user system interface is usually located in the user’s desktop environment and the database management services are usually in a server that is a more powerful machine that services many clients.

## Three-Tier Database Architecture –
In three-tier, the application logic or process lives in the middle-tier, it is separated from the data and the user interface. Three-tier systems are more scalable, robust and flexible. In addition, they can integrate data from multiple sources. In the three-tier architecture, a middle tier was added between the user system interface client environment and the database management server environment. There are a variety of ways of implementing this middle tier, such as transaction processing monitors, message servers, or application servers.

## Sample Two Tier Application:

* Install Firewall
* Install MariaDB
* Configure Firewall
* Configure Database
* Load Data

## Install Firewall

```bash
sudo yum install firewalld
sudo service firewalld start
sudo systemctl enable firewalld
```

## Install MariaDB

```bash
sudo yum  install mariadb-server
sudo vi /etc/my.cnf # configure the file with the right port
sudo service mariadb start  # start maria db
```

## Configure Firewall

```bash
sudo firewall-cmd -permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload
```

## Configure Database

```bash
$ mysql
MariaDB > CREATE DATABASE ecomdb
MARIADB > CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword'
MARIADB > GRANT ALL PRIVILEGE
```
