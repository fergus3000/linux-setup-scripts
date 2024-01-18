#!/bin/bash
# NB Script assumes that Docker is already installed
# Update the system
sudo apt update -y
sudo apt upgrade -y

# Install prerequisite packages
sudo apt install -y curl wget

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Start Minikube
minikube start

# Enable Minikube to start at boot
# Create Minikube systemd service file if it does not exist
if [ ! -f /etc/systemd/system/minikube.service ]; then
  sudo tee /etc/systemd/system/minikube.service <<EOF
[Unit]
Description=Startup minikube service
After=docker.service

[Service]
Type=oneshot
ExecStart=/usr/bin/minikube start
RemainAfterExit=true
ExecStop=/usr/bin/minikube stop
StandardOutput=journal
User=$USER
Group=$USER

[Install]
WantedBy=multi-user.target
EOF
fi
# Get the service to start with systemctl
sudo systemctl daemon-reload
sudo systemctl enable minikube.service
# Enable Minikube to start at boot
sudo systemctl daemon-reload
sudo systemctl enable minikube.service
