#!/bin/bash
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <leaf_cert.pem> <intermediate_cert.pem>"
    exit 1
fi

openssl verify -show_chain -untrusted $2 $1
