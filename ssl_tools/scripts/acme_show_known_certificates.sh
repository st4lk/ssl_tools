#!/bin/bash
BASE_DIR=`dirname "$0"`
WORK_DIR=${BASE_DIR}/../output/acme
LOGS_DIR=${WORK_DIR}/logs

certbot \
  certificates \
  --debug \
  --work-dir ${WORK_DIR} \
  --config-dir ${WORK_DIR} \
  --logs-dir ${LOGS_DIR}
