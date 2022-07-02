# Lab topics

* To get an ip address assigned it should be first connected to network interface adapter
* To check the existing ip addresses -

    ```bash
	$ ip addr
    ```

* To add ip addr,

	```bash
    $ ip addr add 192.168.238.15/24 dev eth0
    ```

* To SSH to an server or machine (root = user, hostname = app01)

	```bash
    $ ssh root@app01
    ```