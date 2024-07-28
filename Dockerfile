FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server build-essential
RUN mkdir /var/run/sshd
RUN echo 'root:ubuntu' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN service ssh restart
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

