#!/bin/bash
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <public_key.pem> <signature.bin>"
    exit 1
fi

openssl rsautl -verify -inkey $1 -in $2 -pubin | openssl asn1parse -inform der
