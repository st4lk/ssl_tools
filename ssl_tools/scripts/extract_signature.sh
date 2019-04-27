#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <cert_file.pem>"
    exit 1
fi

echo `openssl x509 -in $1 \
    -text -noout \
    -certopt ca_default \
    -certopt no_validity \
    -certopt no_serial \
    -certopt no_subject \
    -certopt no_extensions \
    -certopt no_signame \
    | grep -v 'Signature Algorithm' \
    | tr -d '[:space:]:'` \
    | xxd -r -p
