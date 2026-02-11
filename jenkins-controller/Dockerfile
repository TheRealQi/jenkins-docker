FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt-get update && apt-get install -y openssh-client && apt-get clean

COPY setup-keys.sh /usr/local/bin/setup-keys.sh
RUN chmod +x /usr/local/bin/setup-keys.sh

ENTRYPOINT ["/usr/local/bin/setup-keys.sh"]