#!/bin/bash

# Variables
KEY_PATH="$HOME/.ssh/mc_server_auto"
USER="ec2-user"
HOST=$(cat server_ip.txt)

# configure the instance, install docker and docker-compose
ssh -i "$KEY_PATH" "$USER"@"$HOST" << EOF
  sudo yum update -y
  sudo yum install docker -y
  sudo systemctl enable docker

  sleep 5
  sudo mkdir -p /usr/local/lib/docker/cli-plugins/
  sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
  sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
  sudo docker compose version

  sudo systemctl start docker
  mkdir server
EOF

# Copy docker compose to the ec2
scp -i "$KEY_PATH" ./docker_create_mc_server.yml "$USER"@"$HOST":~/server/docker-compose.yml

# copy the service file to the ec2
scp -i "$KEY_PATH" ./docker_boot.service "$USER"@"$HOST":~/server/docker_boot.service
#
ssh -i "$KEY_PATH" "$USER"@"$HOST" << EOF
  sudo cp -v ~/server/docker_boot.service /etc/systemd/system
  sudo systemctl enable docker_boot.service
  sudo systemctl start docker_boot.service
EOF
