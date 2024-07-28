SHELL = /bin/bash

USERNAME := $(shell id --user --name)
BUILD := $(USERNAME)-build

build:
	echo "##### running build on $(BUILD)"
	docker build -t $(BUILD):latest .

clean:
	echo "##### running clean on $(BUILD)"
	docker stop $(BUILD)
	docker rm $(BUILD)
	docker system prune -f

run:
	echo "##### starting  container $(BUILD)"
	docker run -d -p 2222:22 --name $(BUILD) \
		--volume /etc/passwd:/etc/passwd:ro \
		--volume /etc/group:/etc/group:ro \
		--volume /etc/shadow:/etc/shadow:ro $(BUILD) \
		--volume /home/$(USERNAME):/home/$(USERNAME)

stop:
	echo "##### stopping container $(BUILD)"
	docker stop $(BUILD)

ipget:
	echo "##### query container $(BUILD) for it's IP address"
	sudo docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${BUILD}

show:
	docker ps

