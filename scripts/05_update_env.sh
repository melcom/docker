#!/bin/sh
 
###
## Update Docker env
###
 
fqdn="$(hostname).westeurope.cloudapp.azure.com"

echo "export DOCKER_HOST=tcp://$fqdn:2376" >> ~/.bashrc 
echo "export DOCKER_TLS_VERIFY=1" >> ~/.bashrc
echo "export DOCKER_CERT_PATH=/etc/docker/" >> ~/.bashrc
