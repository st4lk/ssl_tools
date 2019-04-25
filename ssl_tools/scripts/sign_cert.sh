#!/bin/bash
BASE_DIR=`dirname $0`/../output
CERTIFICATES_DIR=${BASE_DIR}/server_certificates
SERVER_DIR=${BASE_DIR}/../server

mkdir -p ${CERTIFICATES_DIR}

openssl ca -config ${SERVER_DIR}/openssl-ca.cnf \
    -batch \
    -policy signing_policy \
    -extensions signing_req \
    -out ${CERTIFICATES_DIR}/server-cert.pem \
    -infiles ${CERTIFICATES_DIR}/server-cert.csr
