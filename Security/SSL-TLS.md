# SSL-TLS

## Certificate

A certificate guarantee that the trust between two parties during a tracsaction.  For example when user try to access a webserver, TLS certificate ensure that the communication betweeen the user and webserver is encripted and the server is who it says it is.

Without the certification when the user send some information to the server the data (eg: when user type credentials and send to server for validaation.) would be sent as plain text format.  It can be hacked easily. So it should be encrypted by a key and send to the server and the server need to decrypt the data using the key to read it and the data is safe in the transaction as it is encrypted and can't be recongnised.

Transport Layer Security (TLS) is the successor protocol to SSL. TLS is an improved version of SSL. It works in much the same way as the SSL, using encryption to protect the transfer of data and information. The two terms are often used interchangeably in the industry although SSL is still widely used.

```bash
# Creating public, private RSA

thor@jump_host ~$ ssh-keygen -t rsa -f "/home/thor/.ssh/mykey"
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/thor/.ssh/mykey.
Your public key has been saved in /home/thor/.ssh/mykey.pub.
The key fingerprint is:
SHA256:iLhfA5XWbB/8DSEQ9GWdwxNsvNxy9FUdxgD5wyrn9eM thor@jump_host.stratos.xfusioncorp.com
The key's randomart image is:
+---[RSA 2048]----+
|       .+o..**+==|
|       + o = .@.+|
|      + + + +o *o|
|   . + o . o *+ +|
|  . o . S . o oo |
|   . .   . o .   |
|  .   o   + . .  |
|   . . .   .   o |
|    .         .E.|
+----[SHA256]-----+

```

Using the mykey SSH key-pair you created in previous question configure password less SSH connection between jump host and app01 for user thor. (thor user should already be there on both servers).

Note: There might be password less SSH connection between jump host and app01 for user thor but through default SSH keys, make sure to configure the same using the SSH key pair you created.

```bash
thor@jump_host ~$ ssh-copy-id -i ~/.ssh/mykey.pub thor@app01
/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/thor/.ssh/mykey.pub"
The authenticity of host 'app01 (172.16.238.11)' can't be established.
ECDSA key fingerprint is SHA256:utrTV87dyOEcbwhJmb/EG9slFcS0/Tp6yjWr0UJ7zss.
ECDSA key fingerprint is MD5:54:4d:72:61:bd:d3:73:71:a6:27:fb:98:4b:18:e9:32.
Are you sure you want to continue connecting (yes/no)? yes 
/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'thor@app01'"
and check to make sure that only the key(s) you wanted were added.

# the same can be done as below

# Copy contents of /home/thor/.ssh/mykey.pub public key from jump host and add # the same to /home/thor/.ssh/authorized_keys on app01 server.
```

```bash
sudo yum install -y openssl  # to install openssl package
```

On app01 create a CSR (certificate signing request) /etc/httpd/csr/app01.csr (key name should be app01.key). Below are the required details which should be used while creating CSR.

a. Country Name = SG

b. State or Province Name = Capital Tower

c. Locality Name = CT

d. Organization Name = KodeKloud

e. Organizational Unit Name = Education

f. Common Name = app01.com

g. Email Address = admin@kodekloud.com

h. Keep challenge password blank.

i. Keep optional company name blank.

```bash
[thor@app01 ~]$ cd /etc/httpd/csr
[thor@app01 csr]$ sudo openssl req -newkey rsa:2048 -nodes -keyout app01.key -out app01.csr
Generating a 2048 bit RSA private key
.......+++
........................................................+++
writing new private key to 'app01.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:SG
State or Province Name (full name) []:Capital Tower
Locality Name (eg, city) [Default City]:CT
Organization Name (eg, company) [Default Company Ltd]:KodeKloud
Organizational Unit Name (eg, section) []:Education
Common Name (eg, your name or your server's hostname) []:app01.com
Email Address []:admin@kodekloud.com

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:   
An optional company name []:
[thor@app01 csr]$ 
```

Great! We have now generated the CSR. We must now send it to a CA to get it signed. However there is no CA available for this lab, so we will create our own self signed certificate.

On app01 create a self signed certificate /etc/httpd/certs/app01.crt (key name should app01.key). Below are the required details which should be used while creating the certificate.

a. Country Name = SG

b. State or Province Name = Capital Tower

c. Locality Name = CT

d. Organization Name = KodeKloud

e. Organizational Unit Name = Education

f. Common Name = app01.com

g. Email Address = admin@kodekloud.com

```bash
[thor@app01 csr]$ cd /etc/httpd/certs
[thor@app01 certs]$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout app01.key -out app01.crt
Generating a 2048 bit RSA private key
......................................+++
..............................+++
writing new private key to 'app01.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:SG
State or Province Name (full name) []:Capital Tower
Locality Name (eg, city) [Default City]:CT
Organization Name (eg, company) [Default Company Ltd]:KodeKloud
Organizational Unit Name (eg, section) []:Education
Common Name (eg, your name or your server's hostname) []:app01.com
Email Address []:admin@kodekloud.com
[thor@app01 certs]$ 
```

On app01 server we have an Apache web server already installed and configured and ssl mode is already enabled. In the /etc/httpd/conf.d/ssl.conf file update the SSL certificate and key to use your app01.crt and app01.key files. After making changes remember to restart Apache config.

For your reference the certificate you created in the previous steps is at /etc/httpd/certs/app01.crt and the key is at /etc/httpd/certs/app01.key. The properties in the file are SSLCertificateFile and SSLCertificateKeyFile. To test if server is using correct certificate or not run this command and check if it returns your certificate:

echo | openssl s_client -showcerts -servername app01.com -connect app01:443 2>/dev/null | openssl x509 -inform pem

```bash
Modify the settings in the file /etc/httpd/conf.d/ssl.conf to point to the self signed cert and key you created. Then restart httpd service using the command sudo service httpd restart
```
