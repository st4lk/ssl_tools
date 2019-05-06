#!/bin/bash

BASE_DIR=`dirname "$0"`
WORK_DIR=${BASE_DIR}/../output/acme
LOGS_DIR=${WORK_DIR}/logs

mkdir -p ${WORK_DIR}
mkdir -p ${LOGS_DIR}

FORCE_RENEW=""

if [ "$1" == "force" ]; then
    FORCE_RENEW="--force-renewal"
fi

certbot renew \
  --debug \
  ${FORCE_RENEW} \
  --dns-luadns \
  --dns-luadns-credentials ${BASE_DIR}/luadns_credentials/secrets.ini \
  --work-dir ${WORK_DIR} \
  --config-dir ${WORK_DIR} \
  --logs-dir ${LOGS_DIR} \
