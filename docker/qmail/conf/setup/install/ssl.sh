#!/bin/bash

set -e

# Get the variables
source /app/setup/install/env

openssl req -nodes -x509 -newkey rsa:4096 -keyout ${SSL_KEYFILE} -out ${SSL_CERTFILE} -days 3650 \
  -subj "/C=DE/ST=BW/L=Stuttgart/O=My Inc/OU=DevOps/CN=www.example.com/emailAddress=dev@www.example.com"

touch ${SSL_COMBINEDFILE}
cat ${SSL_KEYFILE} >> ${SSL_COMBINEDFILE}
cat ${SSL_CERTFILE} >> ${SSL_COMBINEDFILE}
#openssl req -nodes -x509 -newkey rsa:4096 -keyout test.pem -out test.crt -days 3650 \
  #  -subj "/C=DE/ST=BW/L=Stuttgart/O=My Inc/OU=DevOps/CN=www.example.com/emailAddress=dev@www.example.com"
