# MongoDB

*  is a document database with the scalability and flexibility that you want with the querying and indexing that we need.

* It stores data as doucument.

## Features

* Open source
* NoSQL
* Scalable
* High Performance

## Data

* Document - single data is called as document
* Collection - Multiple datta together forms collection
* Database - Multiple collections together forms a database
* Mutltiple database can be available in single mongoDB server

## Steps:

* Configure package management system (yum).
* Install mongodb-org  ```yum install mongodb-org```
* Start mongoDB service ```systemctl start mongd```
* Check the service status ```systemctl status mongod```

## Logs:

* Stored in mongod.log  ``` cat /var/log/mongodb/mongod.log ```
* 

## Port:

* Default port is 27017
* It can be changed by editing the config file. ``` /etc/mongod.conf ```

```yaml
# Sample config file

systemLog:
   destination: file
   path: "/var/log/mongodb/mongod.log"
   logAppend: true
storage:
   journal:
      enabled: true
processManagement:
   fork: true
net:
   bindIp: 127.0.0.1
   port: 27017
setParameter:
   enableLocalhostAuthBypass: false
...
```

## Accessing Mongodb:

* We can connect mongo DB using mongo command ``` $ mongo ```
* By default Access control is not enabled.
* Read and write access to data and configuration is unrestricted by default.


## Commands by mongo shell

```shell
$ mongo  # to connect mongo
mongo> show dbs
mongo> use school  # to create new database or switch to existingh database
mongo> db # to check the current database we are working on
mongo> db.createCollection("persons") # to create a collection person inside the school db returns {"ok":1} success response.
mongo> show collections # to show the collections in the current db
mongo> db.persons.insert({"name":"John Doe","location":"New york"}) # create a new document in the collection persons.
mongo> db.persons.find() # list all the documents in the collections
mongo> db.person.find({"name":"John Doe"}) # to find the exact data in the documents for the given parameter
```


## Installation Steps:

https://linuxize.com/post/how-to-install-mongodb-on-centos-7/


