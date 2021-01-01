#!/bin/bash

# ssh_certbot.sh的配置文件

#docker_compose yml文件路径
docker_compose_yml="/home/{your director}/certbot-toy/docker-env/docker-compose.yml"

#注册邮箱
certbot_email="yourEmail@example.com"

#证书映射域名数组
declare -A cert_domain_map
cert_domain_map["example.com"]="*.example.com"