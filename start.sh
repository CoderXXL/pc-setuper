#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root! exiting now..."
  exit
fi

echo "Updating"
sleep 1
# Install apt packages
source "./scripts/apt-packages.sh"

echo "Install docker"
sleep 1
# Install docker
source "./scripts/docker.sh"

echo "Install docker compose (as plugin)"
sleep 1
# Install docker compose
source "./scripts/docker-compose.sh"
