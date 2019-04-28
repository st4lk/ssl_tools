#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <cert_file.pem>"
    exit 1
fi

openssl x509 -noout -issuer_hash -in $1
