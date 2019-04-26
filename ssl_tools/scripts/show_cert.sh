#!/bin/bash
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <domain> <port>"
    exit 1
fi

openssl s_client -connect $1:$2 -servername $1 -showcerts << EOF
