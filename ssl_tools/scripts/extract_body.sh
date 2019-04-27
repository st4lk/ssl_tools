#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <cert_file.pem>"
    exit 1
fi

openssl x509 -in $1 -outform PEM | openssl asn1parse -strparse 4 -noout -out >(cat)
