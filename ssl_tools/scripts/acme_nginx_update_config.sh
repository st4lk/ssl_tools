#!/bin/bash
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <mode> <domain1> [<domain2> ... <domainN>]"
    exit 1
fi

CERT_MODE="--test-cert"
if [ "$1" == "staging" ]; then
  CERT_MODE="--test-cert"
elif [ "$1" == "live" ]; then
  CERT_MODE=""
else
  echo "<mode> argument should be one of 'staging' or 'live'"
  exit 1
fi

BASE_DIR=`dirname "$0"`
WORK_DIR=${BASE_DIR}/../output/acme
LOGS_DIR=${WORK_DIR}/logs
CREDENTIALS_PATH=${BASE_DIR}/../acme_letsencrypt/luadns_credentials/secrets.ini

mkdir -p ${WORK_DIR}
mkdir -p ${LOGS_DIR}

DOMAINS=""
for domain in "${@:2}"
do
    DOMAINS="${DOMAINS} -d ${domain}"
done

certbot run \
  ${CERT_MODE} \
  --authenticator dns-luadns \
  --dns-luadns \
  --dns-luadns-credentials ${CREDENTIALS_PATH} \
  --dns-luadns-propagation-seconds 330 \
  --installer nginx \
  --debug \
  --agree-tos \
  --work-dir ${WORK_DIR} \
  --config-dir ${WORK_DIR} \
  --logs-dir ${LOGS_DIR} \
  ${DOMAINS}
