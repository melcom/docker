#!/bin/sh

###
## Create cert dir
###
certdir=~/cert

if [ -d "$certdir" ]; then
  rm -Rf $certdir
fi

mkdir $certdir

###
## Create ca key
###

sudo openssl genrsa -out $certdir/ca-key.pem 2048

###
## Create ca cert
###

sudo openssl req -config /usr/lib/ssl/openssl.cnf -new -key $certdir/ca-key.pem -x509 -days 1825 -out $certdir/ca.pem

