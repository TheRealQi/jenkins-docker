FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt-get update && apt-get install -y openssh-client && apt-get clean

# Simple script to generate keys if they don't exist
RUN echo '#!/bin/bash\n\
mkdir -p /var/jenkins_home/.ssh\n\
if [ ! -f /var/jenkins_home/.ssh/id_ed25519 ]; then\n\
  ssh-keygen -t ed25519 -f /var/jenkins_home/.ssh/id_ed25519 -N ""\n\
fi\n\
chown -R jenkins:jenkins /var/jenkins_home/.ssh\n\
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh' > /usr/local/bin/jenkins-wrapper.sh

RUN chmod +x /usr/local/bin/jenkins-wrapper.sh

USER jenkins
ENTRYPOINT ["/usr/local/bin/jenkins-wrapper.sh"]