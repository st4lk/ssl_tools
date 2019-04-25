#!/bin/bash
BASE_DIR=`dirname $0`/../output
CERTIFICATES_DIR=${BASE_DIR}/server_certificates
SERVER_DIR=${BASE_DIR}/../server

mkdir -p ${CERTIFICATES_DIR}

# -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=IP:127.0.0.1,DNS:localhost")) \
openssl req -new -subj \
    '/CN=localhost' \
    -batch \
    -reqexts SAN \
    -config ${SERVER_DIR}/openssl-server.cnf \
    -out ${CERTIFICATES_DIR}/server-cert.csr \
    -nodes \
    -newkey rsa:2048 \
    -keyout ${CERTIFICATES_DIR}/server-key.pem
