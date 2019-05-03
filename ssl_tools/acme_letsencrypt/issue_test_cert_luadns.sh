#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <domain1> [<domain2> ... <domainN>]"
    exit 1
fi
BASE_DIR=`dirname "$0"`
WORK_DIR=${BASE_DIR}/../output/acme
LOGS_DIR=${WORK_DIR}/logs

mkdir -p ${WORK_DIR}
mkdir -p ${LOGS_DIR}

DOMAINS=""
for domain in "$@"
do
    DOMAINS="${DOMAINS} -d ${domain}"
done

certbot certonly \
  --test-cert \
  --debug \
  --agree-tos \
  --dns-luadns \
  --dns-luadns-credentials ${BASE_DIR}/luadns_credentials/secrets.ini \
  --dns-luadns-propagation-seconds 330 \
  --work-dir ${WORK_DIR} \
  --config-dir ${WORK_DIR} \
  --logs-dir ${LOGS_DIR} \
  ${DOMAINS}
