#!/bin/bash

set -o allexport
source ./scripts/docker/config/sys.env
source ./scripts/docker/config/user.env
set +o allexport

docker run \
--name certbot \
-itd \
-v ${LETSENCRYPT_CONF_DIR}:/etc/letsencrypt \
-v ${LETSENCRYPT_WORK_DIR}:/var/lib/letsencrypt \
-v ${LETSENCRYPT_LOG_DIR}:/var/log/letsencrypt \
-v ${USER_CONFIG_DIR}:${APP_DIR}config/ \
-e ACCESS_KEY_ID=${ACCESS_KEY_ID} \
-e ACCESS_KEY_SECRET=${ACCESS_KEY_SECRET} \
-e ENDPOINT=${ENDPOINT} \
-e LETSENCRYPT_USER_EMAIL=${LETSENCRYPT_USER_EMAIL} \
xubeijun/certbot-toy:latest
