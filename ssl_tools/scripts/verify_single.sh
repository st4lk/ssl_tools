#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <leaf_cert.pem>"
    exit 1
fi

openssl verify -show_chain $1
