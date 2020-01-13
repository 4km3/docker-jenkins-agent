FROM ubuntu:bionic
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>

LABEL Description="Ubuntu container to be used as a Jenkins agent " \
      Vendor="ACME Products"                                        \
      Version="1.0"

USER root

RUN  set -e;                                         \
     mkdir -p /var/run/sshd;                         \
     apt update;                                     \
     apt full-upgrade -y;                            \
     apt install -y build-essential                  \
                   git                               \ 
                   sudo                              \
                   openssh-server                    \
                   docker-compose                    \
                   openjdk-8-jdk;                    \
     apt autoremove;                                 \
     apt clean;                                      \
     /usr/bin/ssh-keygen -A;                         \
     useradd -m -d /home/jenkins -s /bin/sh jenkins; \
     echo 'jenkins:jenkins' | chpasswd;              \
     echo 'jenkins ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/10-sudo

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
