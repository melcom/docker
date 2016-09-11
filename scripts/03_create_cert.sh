#!/bin/sh

certdir=~/cert

###
## Generate server cert
###

subj="/CN=$(hostname).westeurope.cloudapp.azure.com"

sudo openssl genrsa -out $certdir/key.pem 2048
sudo openssl req -subj $subj -new -key $certdir/key.pem -out $certdir/server.csr 

sudo openssl x509 -req -days 1825 -in $certdir/server.csr -CA $certdir/ca.pem -CAkey $certdir/ca-key.pem -CAcreateserial -out $certdir/cert.pem -extensions v3_req -extfile /usr/lib/ssl/openssl.cnf
sudo openssl rsa -in $certdir/key.pem -out $certdir/key.pem
 
###
## Generate client cert
###

cp /usr/lib/ssl/openssl.cnf $certdir/clientopenssl.cnf
echo extendedKeyUsage = clientAuth >> $certdir/clientopenssl.cnf
 
sudo openssl genrsa -out $certdir/client-key.pem 2048
sudo openssl req -subj "/CN=client" -new -key $certdir/client-key.pem -out $certdir/client.csr
sudo openssl x509 -req -days 1825 -in $certdir/client.csr -CA $certdir/ca.pem -CAkey $certdir/ca-key.pem -CAcreateserial -out $certdir/client-cert.pem -extensions v3_req -extfile $certdir/clientopenssl.cnf
sudo openssl rsa -in $certdir/client-key.pem -out $certdir/client-key.pem
 
###
## Cleanup
###

rm -f $certdir/*.srl $certdir/*.csr $certdir/*.cnf

###
## Copy certificate
###

sudo rm -f /etc/docker/*.pem
sudo cp $certdir/ca.pem /etc/docker/
sudo cp $certdir/cert.pem /etc/docker/
sudo cp $certdir/key.pem /etc/docker/
sudo chmod 750 /etc/docker
sudo chgrp docker -R /etc/docker/
