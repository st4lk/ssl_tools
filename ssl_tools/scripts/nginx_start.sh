#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath -s $0))
NGINX_PATH=/etc/nginx
NGINX=/etc/init.d/nginx
NGINX_OUTPUT_PATH=${SCRIPT_PATH}/../output/nginx

mkdir -p ${NGINX_OUTPUT_PATH}
# Copy, but don't overwrite (-n option)
cp -n ${SCRIPT_PATH}/../nginx/sites-available/acme_example.source ${NGINX_OUTPUT_PATH}/acme_example

# create or update symlinks
ln -sf ${NGINX_OUTPUT_PATH}/acme_example ${NGINX_PATH}/sites-available/acme_example
ln -sf ${NGINX_PATH}/sites-available/acme_example ${NGINX_PATH}/sites-enabled/acme_example

${NGINX} start
${NGINX} reload

