#!/bin/sh
set -e

SHARED_PUB_KEY="/home/jenkins/.ssh-shared/id_ed25519.pub"

echo "Waiting for shared public key from controller"
while [ ! -f "$SHARED_PUB_KEY" ]; do
  sleep 2
done

mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh

cat "$SHARED_PUB_KEY" > /home/jenkins/.ssh/authorized_keys
chmod 600 /home/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /home/jenkins/.ssh
exec setup-sshd "$@"