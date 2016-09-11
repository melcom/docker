#!/bin/sh

###
## Create Docker override conf
###

sudo mkdir /etc/systemd/system/docker.service.d/
sudo touch /etc/systemd/system/docker.service.d/override.conf

echo "[Service]" | sudo tee -a /etc/systemd/system/docker.service.d/override.conf
echo "ExecStart=" | sudo tee -a /etc/systemd/system/docker.service.d/override.conf
echo "ExecStart=/usr/bin/docker daemon --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/cert.pem --tlskey=/etc/docker/key.pem -H=0.0.0.0:2376" | sudo tee -a /etc/systemd/system/docker.service.d/override.conf

###
## Apply configuration & restart Docker
###

sudo systemctl daemon-reload
sudo systemctl restart docker
