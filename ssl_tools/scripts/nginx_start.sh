#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath -s $0))
NGINX_PATH=/etc/nginx
NGINX=/etc/init.d/nginx
NGINX_OUTPUT_PATH=${SCRIPT_PATH}/../output/nginx

mkdir -p ${NGINX_OUTPUT_PATH}
for file_path in ${SCRIPT_PATH}/../nginx/sites-available/*.source;
do
    # Copy all *.source files to output folder
    file_name=$(basename ${file_path})
    result_file_name=$(echo ${file_name} | cut -d. -f1)
    # Copy, but don't overwrite (-n option)
    cp -n ${file_path} ${NGINX_OUTPUT_PATH}/${result_file_name}
    # create or update symlinks
    ln -sf ${NGINX_OUTPUT_PATH}/${result_file_name} ${NGINX_PATH}/sites-available/${result_file_name}
    ln -sf ${NGINX_PATH}/sites-available/${result_file_name} ${NGINX_PATH}/sites-enabled/${result_file_name}

done

${NGINX} start
${NGINX} reload

