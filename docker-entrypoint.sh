#!/bin/bash

function selfsigned(){
# Specify where we will install
# the xip.io certificate
SSL_DIR="/etc/certs/"

# Set the wildcarded domain
# we want to use
DOMAIN="*.xip.io"

# A blank passphrase
PASSPHRASE=""

# Set our CSR variables
SUBJ="
C=US
ST=Connecticut
O=
localityName=New Haven
commonName=$DOMAIN
organizationalUnitName=
emailAddress=
"

# Create our SSL directory
# in case it doesn't exist
mkdir -p "$SSL_DIR"

# Generate our Private Key, CSR and Certificate
openssl genrsa -out "$SSL_DIR/cert.key" 2048
openssl req -new -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key "$SSL_DIR/cert.key" -out "$SSL_DIR/cert.csr" -passin pass:$PASSPHRASE
openssl x509 -req -days 365 -in "$SSL_DIR/cert.csr" -signkey "$SSL_DIR/cert.key" -out "$SSL_DIR/cert.crt"
}

if [ ! -e "/etc/certs/cert.pem" ]
  then
  selfsigned
fi

python /haproxygen.py $server $fqdn $port $haproxyadmin > /etc/haproxy/haproxy.conf

