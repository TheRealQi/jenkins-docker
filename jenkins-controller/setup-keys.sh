#!/bin/bash
set -e

mkdir -p /var/jenkins_home/.ssh

if [ ! -f /var/jenkins_home/.ssh/id_ed25519 ]; then
    echo "Generating new SSH key pair..."
    ssh-keygen -t ed25519 -f /var/jenkins_home/.ssh/id_ed25519 -N "" -q
    echo "Key pair generated successfully."
else
    echo "SSH key already exists. Skipping generation."
fi

chmod 644 /var/jenkins_home/.ssh/id_ed25519.pub
chown -R jenkins:jenkins /var/jenkins_home/.ssh

echo "Starting Jenkins..."
exec runuser -u jenkins -- /usr/bin/tini -- /usr/local/bin/jenkins.sh
