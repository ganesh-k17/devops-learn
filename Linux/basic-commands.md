```bash
touch filename -> to create a file 

mkdir –p asia/india/tamilnadu -> create hierarchy of directories. 

rm asia/india/tamilandu/test.txt -> remove a specific files 

 

Cat > test.txt 

//type whatever you want to add content to the test.txt file 

// press Ctrl+d to stop editing and back to terminal 

Cat test.txt 

// To view the content of the file. 

Vi test.txt 

// to edit test.txt file via VI editor 

// on insert mode, add the content and press esc 

// then :wq to save the content and back to terminal 

// or :q to avoid the save and back to terminal 

 

/* 

If you want to save and then quit VIM, type the following 
:wq Enter 
or 
you can also type the following 
:w Enter     <-------- This command is to save the file 
:q Enter     <-------- This command quit VIM 

If you want to quit without saving any changes, type the following 
:q! Enter 

 :q! or :wq! => for quiting from readonly file.

Find => /<word to search in editor> 

*/ 

 

 

Move Around 
Delete 
Copy & Paste 
dd 
 

 

Other Commands: 

 

whoami 

id 

su ganku  // switch to other user it will prompt for password 

  

ssh ganku@192.168.1.2 => to login to a machine with a user 

  

ls /root => could not be accessed by other user other than root user. 

  

can be viewed by sudo, 

  

sudo ls /root  => it will prompt password for first time. 

  

  

downloading file: 

  

curl http://www.some-site.com/some-file.txt  => to just view the file in screen 

curl http://www.some-site.com/some-file.txt -O  => to save as file in local. 

  

  

wget https://gmolsolutions.com/wp-content/uploads/2020/06/image-43.png -O myImage.png 

  

  

Check OS version:  

  

ls /etc/*release* 

  

cat /etc/*release* 

  

Package management: 

  

RPM (Red Hat Package Management) 

  

rpm -i telnet.rpm  => install package 

rpm -e telnet.rpm  => uninstall package 

rpm -q telnet.rpm  => query package 

  

  

YUM => yum install package with RPM behind but with all the dependencies  

while rpm does not install the dependencies 

  

yum install ansible 

yum repolist   => to check the available repolist for yum 

ls /etc/yum.repos.d/ 

cat /etc/yum.repos.d/CentOS-Base.repo 

yum list ansible 

yum remove ansible 

yum --showduplicates list ansible 

yum install ansible-2.4.2.0 

 

  

installing rpm: 

  

sudo add-apt-repository universe  => check the status of the universe destribution compnent 

sudo apt-get update  => make sure the repositories are up-to-date 

sudo apt-get install alien  => install Alien conversion tool 

sudo alien packagename.rpm  => the command instructs the Alien tool to intiate the conversion process of the .rpm file to a .deb file 

sudo dbkg -i packagename.dev => insgall the converted .rpm package on Ubuntu 

  

Installing the .rpm package directly on Ubunt. 

  

  

sudo alien -i packagename.rpm 
```