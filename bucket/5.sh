#!/bin/bash

# Update the package index
sudo apt update


# Install Docker
sudo apt install -y docker.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Pull the Nginx image
sudo docker pull nginx

# Run the Nginx container
sudo docker run --name my-nginx -p 80:80 -d nginx


# Output the status
echo "Nginx server is running on http://localhost"
