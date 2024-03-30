# Docker Commands

## Basic Commands

- docker run `docker run nginx` `Download the image if not exist and run the image`
- docker ps `# to list running containers`
- docker ps -a `# to list running and stopped containers`
- docker stop `docker stop mycontainer` `# To stop a specific ccontainer`
- docker rm `docker rm mycontainer` `# to remove a container`
  `docker rm a03 34j 983 82s` `to remove multiple container`
- docker images `# to list available images in local`
- docker rmi `docker rmi nginx` `To remove a specific image - but before removing all the containers using this image should be deleted before delteting this image`
- docker pull `docker pull nginx` `To download a image not run the command`
- docker run -it myContainer bash `it will run the container and make you go into the container`

## Other commands

Append a command

`docker run ubuntu sleep 5`

Exec - Execute a command with a container

`docker exec mycontainer cat /etc/hosts`

Run - attach and detach

```bash
docker run kodekloud/simple-webapp
docker run -d kodekloud/simple-webapp
docker attach a043d # here a043d is container id
```

## Others

To stop all the containers at once, run the command: `docker stop $(docker ps -aq)`

`-aq used for display only the ids of the container`

To remove all the stopped containers at once, run the command: `docker rm $(docker ps -aq)`

To remove all the images : `docker rmi $(docker images -aq)`

To run a container and name it `docker run --name webapp nginx:1.14-alpine`
