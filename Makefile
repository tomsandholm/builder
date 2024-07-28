SHELL = /bin/bash

USERNAME := $(shell id --user --name)
BUILD := $(USERNAME)-build

build:
	docker build -t $(BUILD) .

clean:
	docker stop $(BUILD)
	docker rm $(BUILD)
	docker system prune -f

run:
	#docker run -d -p 2222:22 --name $(BUILD)
	docker run -d -p 2222:22 --name $(BUILD) \
		--volume /etc/passwd:/etc/passwd:ro \
		--volume /etc/group:/etc/group:ro \
		--volume /home/${USERNAME}:/home/${USERNAME} \
		--volume /etc/shadow:/etc/shadow:ro $(BUILD)

stop:
	docker stop $(BUILD)

ipget:
	sudo docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${BUILD}

show:
	docker ps

