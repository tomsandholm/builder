# builder
Makefile and Dockerfile to build generic private build server for a developer

This package will create a private docker image to be used by a developer to implement an isolated OS space sometimes required with legacy code.
This image will import the developer space as well as system-credentials, facilitating fast and simple setup of the docker image, and
significantly simplifying the procedure.  As a result these images and containers are multi-user capable.  Each user will clone this base
code, then run thru the setup to create their own private docker image.  They will clone their project code at the host layer, then spin up
the docker-image to perform the compile/build/etc,etc,etc.


