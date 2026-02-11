#!/bin/bash
set -e

mkdir -p /var/jenkins_home/.ssh
if [ -f /var/jenkins_home/.ssh/id_ed25519 ]; then
    echo "SSH key pair already exists. Skipping generation."
elif [ ! -f /var/jenkins_home/.ssh/id_ed25519 ]; then
    echo "Generating new SSH key pair..."
    su jenkins -c "ssh-keygen -t ed25519 -f /var/jenkins_home/.ssh/id_ed25519 -N '' -q -C 'jenkins@controller'"
    echo "Key pair generated successfully."
fi

chmod 644 /var/jenkins_home/.ssh/id_ed25519.pub
chown -R jenkins:jenkins /var/jenkins_home/.ssh

echo "Starting Jenkins..."
exec runuser -u jenkins -- /usr/bin/tini -- /usr/local/bin/jenkins.sh
