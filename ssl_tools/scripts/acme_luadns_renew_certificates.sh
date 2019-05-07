#!/bin/bash

BASE_DIR=`dirname "$0"`
WORK_DIR=${BASE_DIR}/../output/acme
LOGS_DIR=${WORK_DIR}/logs

mkdir -p ${WORK_DIR}
mkdir -p ${LOGS_DIR}
CREDENTIALS_PATH=${BASE_DIR}/../acme_letsencrypt/luadns_credentials/secrets.ini

FORCE_RENEW=""

if [ "$1" == "force" ]; then
    FORCE_RENEW="--force-renewal"
fi

certbot renew \
  --debug \
  ${FORCE_RENEW} \
  --dns-luadns \
  --dns-luadns-credentials ${CREDENTIALS_PATH} \
  --work-dir ${WORK_DIR} \
  --config-dir ${WORK_DIR} \
  --logs-dir ${LOGS_DIR} \
