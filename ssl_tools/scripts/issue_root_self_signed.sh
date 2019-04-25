#!/bin/bash
BASE_DIR=`dirname $0`/../output
DB_DIR=${BASE_DIR}/.openssl_db
CERTIFICATES_DIR=${BASE_DIR}/server_certificates
SERVER_DIR=${BASE_DIR}/../server

mkdir -p ${DB_DIR}
mkdir -p ${CERTIFICATES_DIR}

# init db
touch ${DB_DIR}/index.txt
test -f ${DB_DIR}/serial.txt || echo '01' > ${DB_DIR}/serial.txt

# issue cert
DB_DIR=${DB_DIR} CERTIFICATES_DIR=/tmp \
openssl req -x509 \
    -batch \
    -config ${SERVER_DIR}/openssl-ca.cnf \
    -newkey rsa:4096 \
    -sha256 \
    -nodes \
    -out ${CERTIFICATES_DIR}/root-self-signed-cert.pem \
    -outform PEM
