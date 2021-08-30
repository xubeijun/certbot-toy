#!/bin/bash

set -o allexport
source ./scripts/docker/config/sys.env
set +o allexport

docker build -f ./scripts/docker/Dockerfile --build-arg APP_DIR=${APP_DIR} -t certbot-toy:latest .