#!/bin/bash

# Update the apt cache
sudo apt update

# Install prerequisite packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common

# Add the GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker APT repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the apt cache again
sudo apt update

# Install Docker Engine
sudo apt install docker-ce

# Enable Docker to start at boot
sudo systemctl enable docker

# Add current user to docker group
sudo usermod -aG docker $USER
