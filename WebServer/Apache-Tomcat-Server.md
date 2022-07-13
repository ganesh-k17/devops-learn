# Apache Tomcat Server

To host Java based applications.

## Install:

Prerequisites:

* Java

```bash

yum install java-1.8.0-openjdk-devel  # install java

wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.53/bin/apache-tomcat-8.5.53.tar.gz # instal apache tomcat serveer

tar xvf apache-tomcat-8.5.53.tar.gz  # extract the downloaded file

./apache-tomcat-8.5.53/bin/startup.sh  # start the server.  Normallly we would start the tomcat server differently that we would  create a user and configure the tomcat as service.

```

## Port:

Default port: 8080

Default page: https://localhost:8080

Tomcat server capable of hosting multiple java based applications.

## Files and folders in tomcat folder:


```
ls -l apache-tomcat-8.5.53

BUILDING.txt
CONTRIBUTING.md
LICENSE
NOTICE
README.md
RUNNING.txt
bin
conf
lib
logs
temp
webapps
work
```

bin:  list of scripts and bat files, startup and shutdown.sh files used to start and stop the server

Conf: Here we would configure web apps. 

## Files in conf folder:

```bash
catalina.policy #	contains the Tomcat security policy for the Catalina java class, expressed in standard Security Policy syntax, as defined in the JEE specification. This is Tomcat’s core security policy, and includes permissions definitions for system code, web applications, and Catalina itself.
catalina.properties	# This file is a standard Java properties file for the Catalina class. It contains information such as security package lists and class loader paths. This file can also contains some String cache settings, that we might edit when tuning our server for best Tomcat performance.
logging.properties	# This file configures the way that Catalina’s built-in logging functions, including things such as threshold and log location. Note that all the entries in this log refer to JULI, the modified commons-logging implementation that Tomcat automatically uses in place of your JDK’s logging implementation.
context.xml	# This XML configuration file is used to define Tomcat Context information that will be loaded for every web application running on a given instance of Tomcat. In general, you should configure your Context information elsewhere, but there are a few entries in this file that can be uncommented to alter the way that Tomcat handles session persistence and Comet connections.
server.xml	# This is Tomcat’s main configuration file, which uses the hierarchical syntax specified in the Java Servlet specification to configure Catalina’s initial state, as well as define the order in which Tomcat boots and builds its various components. This file is quite complex, but comprehensive documentation is available on the Apache website.
tomcat-users.xml	# This file contains information about the various users, passwords, and user roles on a given Tomcat server, as well as information about trusted Realms (JNDI, JDBC, etc.) where this data can be accessed.
web.xml	# This file configures options and values that will be applied to all applications loaded into a given instance of Tomcat, including servlet definitions such as buffer sizes, debugging levels, Jasper options like classpath, MIME types, and default welcome files for directories that do not have their own “index” files. Although you can technically configure options for specific web applications in this file, this will require you to restart your entire server to propagate these changes, so it is not recommended.
```

## Server.xml:

```xml
<?xml version='1.0' encoding='utf-8'?>
<Server port="8005" shutdown="SHUTDOWN">
  <Listener className="org.apache.catalina.core.JasperListener" />
  <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
  <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
  <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
  <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />
  
  <GlobalNamingResources>
    <Resource name="UserDatabase" auth="Container"
              type="org.apache.catalina.UserDatabase"
              description="User database that can be updated and saved"
              factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
              pathname="conf/tomcat-users.xml" />
  </GlobalNamingResources>
  
  <Service name="Catalina">
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
  
    <Engine name="Catalina" defaultHost="localhost">
  
      <Realm className="org.apache.catalina.realm.LockOutRealm">
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
               resourceName="UserDatabase"/>
      </Realm>
  
      <Host name="localhost"  appBase="webapps"
            unpackWARs="true" autoDeploy="true">
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log." suffix=".txt"
               pattern="%h %l %u %t "%r" %s %b" />
      </Host>
    </Engine>
  </Service>
</Server>
```

connector: is the endpoint where the request is received.


## logs:

logs are stored in this directory.  It is the place we have to look into when stuck with any issues to troubleshoot.

## webapps:

Here we Place our application to get it hosted.


## hosting a java app

we would packageing application and place in webapps folder

```bash
jar -cvf app.war *

maven package # build and package the app using maven

gradle build # build and package the app using gradle
```

Once packaging the java app then plac the war file (app.war) in webapps folder.  Then the server would extract the war file inside the directory in the name of the war file.  Which can be verified by viewing the log file

```bash
cat ~/apache-tomcat-8.5.53/logs/catalina.out
```

We can view the app by https://localhost:8080/app


