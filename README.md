# builder
Makefile and Dockerfile to build generic private build server for a developer


This package will create a private docker image to be used by a developer to implement an isolated OS space sometimes required with legacy code.

This image will import the developer space as well as system-credentials, facilitating fast and simple setup of authentication.
We pull in the following files as volume mounts:
-  /etc/sudoers
-  /etc/sudoers.d
-  /etc/group
-  /etc/passwd
-  /etc/shadow
-  /home/${USERNAME}

This means user permissions in the Host OS will persist in the container space.  Or at least that's the hope.  ;-)

These images and containers are multi-user capable.  

Each user will clone this base code, then run thru the setup to create their own private docker image.  

They will clone their project code at the host layer, then spin up the docker-image to perform the compile/build/etc,etc,etc.

# setup

1.  make build

    This will create an image with the name of ${USERNAME}-build:latest.

2.  make run

    This will run a container, mapping the users $HOME, and /etc/passwd, /etc/group, /etc/shadow as readonly to the container.
    All user credentials are included on the volume mounts.
    The container inherits the host-os credentials.

3.  make connect

    This will open an ssh session to the container named ${USERNAME}-build.
    The container has used --net=host networking; meaning the port is available on the Host OS.
    The port for the container ssh is 2222.
    Other systems can access the container ssh service via host ipaddress:2222.

# manage

- Stop container:  make stop

- Start container:  make start

- Show running containers:  make show

- Get ip-address of running container:  make ipget

- Connect to a running container:  make connect

- Destroy everything, massive cleanup:  make clean

- Clean up known_hosts: make sshclean

# Dockerfile

  You will update this file as necessary for the particular software needed.


