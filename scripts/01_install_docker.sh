#!/bin/sh

curl -fsSL https://get.docker.com/ | sh

currentuser=$(whoami)
echo "Adding $currentuser into docker group"
sudo usermod -aG docker $currentuser
