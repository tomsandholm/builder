build:
	docker build -t build:latest .

clean:
	docker system prune -f
	docker image rm build

run:
	#docker run -d -p 2222:22 --name build build:latest
	docker run -d -p 2222:22 --name build \
		--volume /etc/passwd:/etc/passwd:ro \
		--volume /etc/group:/etc/group:ro \
		--volume /home/`id --name --user`:/home/`id --name --user`  \
		--volume /etc/shadow:/etc/shadow:ro build:latest

stop:
	docker stop build

ipget:
	sudo docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' build

show:
	docker ps

