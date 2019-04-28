#!/bin/bash
HELP_MSG="Usage (<capath> or <cafile) must be specified: $0 <leaf_cert.pem> [<capath>] [<cafile>]"
if [ "$#" -lt 2 ]; then
    echo ${HELP_MSG}
    exit 1
fi

if [ "$2" != "0" ]; then
    openssl verify -CApath $2 $1
elif [ "$3" != "0" ]; then
    openssl verify -CAfile $3 $1
else
    echo ${HELP_MSG}
    exit 1
fi
