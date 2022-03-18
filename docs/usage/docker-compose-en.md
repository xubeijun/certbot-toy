## Usage - docker-compose

First you need to go to the directory where your docker-compose.yml file is located.
```sh
cd ${YOUR_DOCKER_COMPOSE_YML_PATH}
```

e.g. View more [certbot-toy usage](../../scripts/docker/docs/help/manage.txt)

```sh
#docker-compose
docker-compose exec certbot certbot-toy -h
```

e.g. print the certificates which certbot knows about.

```sh
#docker-compose
docker-compose exec certbot certbot-toy manage -c
```

e.g. Lists of the valid domain config which is defined in user-config.sh file.

```sh
#docker-compose
docker-compose exec certbot certbot-toy manage -l
```

e.g. Re-creating and updating existing certificates

```sh
#docker-compose
docker-compose exec certbot certbot-toy manage -a certonly -d example.com -p aliyun
```

e.g. Force-renewal existing certificates

```sh
#docker-compose
docker-compose exec certbot certbot-toy manage -a renew -p aliyun
```

e.g. Revoke certificates

```sh
#docker-compose
docker-compose exec certbot certbot-toy manage -a revoke -d example.com -p aliyun
```

e.g. Delete certificates

```sh
#docker-compose
docker-compose exec certbot certbot-toy manage -a delete -d example.com -p aliyun
```

e.g. Re-creating, Force-renewal, Revoke, Delete certificates and restart nginx。
```sh
#docker-compose

#Format
${your_certbot_command} && docker-compose exec nginx nginx -s reload

#Such as
docker-compose exec certbot certbot-toy manage -a certonly -d example.com -p aliyun && docker-compose exec nginx nginx -s reload
```

e.g. Automatically force-renewal existing certificates every 15 days and nginx is restarted.

**notice**, Please replace the `${LETSENCRYPT_LOG_DIR}` variable in the following script, which one is the same value defined in the user.env profile.

**notice**, Please replace the `${YOUR_DOCKER_COMPOSE_YML_PATH}` variable in the following script, which one is your docker-compose.yml file path.

**notice**，Please replace the `${DNS_PLUGIN}` variable in the following script, which one is your third part dns plugin. Its same to the option vale of `-p aliyun`.

**notice**，Please replace the `${BIN_DOCKER_COMPOSE_YML_PATH}` variable in the following script, which one is your docker-compose exec file path.

```sh
which docker-compose
# ${BIN_DOCKER_COMPOSE_YML_PATH} 通常输出为
#/usr/local/bin/docker-compose
```

```sh
#docker
crontab -l > conf && echo "0 0 */15 * * cd ${YOUR_DOCKER_COMPOSE_YML_PATH} && ${BIN_DOCKER_COMPOSE_YML_PATH} exec certbot certbot-toy manage -a renew  -p ${DNS_PLUGIN}  >> ${LETSENCRYPT_LOG_DIR}cron.log 2>&1 && docker-compose exec nginx nginx -s reload" >> conf && crontab conf && rm -f conf
```