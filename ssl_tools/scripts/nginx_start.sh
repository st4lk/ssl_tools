#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath -s $0))
NGINX_PATH=/etc/nginx
NGINX=/etc/init.d/nginx

# create or update symlinks
ln -sf ${SCRIPT_PATH}/../nginx/sites-available/acme_example ${NGINX_PATH}/sites-available/acme_example
ln -sf ${NGINX_PATH}/sites-available/acme_example ${NGINX_PATH}/sites-enabled/acme_example

${NGINX} start

