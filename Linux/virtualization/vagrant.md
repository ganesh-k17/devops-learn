# Vagrant

Vagrant is a tool for building and managing virtual machine environments in a single workflow. With an easy-to-use workflow and focus on automation, Vagrant lowers development environment setup time, increases production parity, and makes the "works on my machine" excuse a relic of the past.

https://www.vagrantup.com/intro

## Commands

```bash
$ vagrant init centos/7
```

This command create a vagrantfile in the directory where the above command ran.  Then we can call 
'Vagrant up' command to install the VM.

```bash
$ vagrant up
```
This command will install the VM
