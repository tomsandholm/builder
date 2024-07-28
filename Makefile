SHELL = /bin/bash

## we will create the image as USERNAME-build
USERNAME := $(shell id --user --name)

## this is our image name
BUILD := $(USERNAME)-build

## task to build a new USERNAME-build:latest image
build:
	echo "##### running build on $(BUILD)"
	docker build -t $(BUILD):latest .

## task to stop container, remove container, remove image and prune system
## modify at your desire
clean:
	echo "##### running clean on $(BUILD)"
	docker stop $(BUILD)|| echo "##### container $(BUILD) not found to stop"
	docker rm $(BUILD)|| echo "##### container $(BUILD) not found to rm"
	docker image rm $(BUILD)|| echo "##### image $(BUILD) not found to rm"
	docker system prune -f

## run the container named USERNAME-build
## map the user $HOME, and host-credentials to the container
run:
	echo "##### starting  container $(BUILD)"
	docker run -d -p 2222:22 --name $(BUILD) \
		--volume /etc/sudoers:/etc/sudoers:ro \
		--volume /etc/sudoers.d:/etc/sudoers.d:ro \
		--volume /etc/passwd:/etc/passwd:ro \
		--volume /etc/group:/etc/group:ro \
		--volume /etc/shadow:/etc/shadow:ro  \
		--volume /home/$(USERNAME):/home/$(USERNAME) $(BUILD)

## stop a running container named USERNAME-build
stop:
	echo "##### stopping container $(BUILD)"
	docker stop $(BUILD)

## start a stopped container
start:
	echo "##### start container $(BUILD)"
	docker start $(BUILD)

## return the assigned ip address of the container
ipget:
	echo "##### query container $(BUILD) for it's IP address"
	sudo docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(BUILD)

## show all containers running
show:
	docker ps

## connect to our private running container, skip host-key conflicts for now
connect:
	ssh -p 2222 -o StrictHostKeyChecking=no $(USERNAME)@localhost || echo "#### session done"

