
## config - docker-compose

File: **init-config.sh**

Path: `${your_path}/certbot-toy/scripts/dns-plugins/init-config.sh`

Descript: Go build third party dns-plugins need these parameters.

Parameter  | Feauture
--      | ----------
 MACHINE_GOOS   | go env command to view the values of GOOS on your machine
 MACHINE_GOARCH | go env command to view the values of GOARCH on your machine

---

File: **.env** [config usage](#env)

Path: `${YOUR_DOCKER_COMPOSE_ENV_PATH}/.env` Your .env file located directory, and docker-compose.yml file need it.

Descript: Run certbot-toy of the docker image need these envionment variables.

Parameter  | Feauture
--      | ----------
 APP_DIR   | it is absolute path, and it means the dockerfile's WORKDIR. <br>This default value is `/usr/local/opt/certbot-dns/`, the default should be the same with the APP_DIR which is defined in `${your_path}/certbot-toy/scripts/docker/config/sys.env` file.
 USER_CONFIG_DIR   | it is absolute path and mounted to `${APP_DIR}config/` in docker directory.
 LETSENCRYPT_CONF_DIR   | it is absolute path and mounted to `/etc/letsencrypt` in docker directory.
 LETSENCRYPT_WORK_DIR   | it is absolute path and mounted to `/var/lib/letsencrypt` in docker directory.
 LETSENCRYPT_LOG_DIR   | it is absolute path and mounted to `/var/log/letsencrypt` in docker directory.
 ACCESS_KEY_ID   | it is the Cloudflare api key id and used in your third part dns plugin sdk and get it from your clound service.
 ACCESS_KEY_SECRET   | it is the Cloudflare api key secret and used in your third part dns plugin sdk and get it from your clound service.
 ENDPOINT   | it is the Cloudflare zone id and used in your third part dns plugin sdk and get it from your clound service.

---

File: **docker-compose.yml** [config usage](#yml)

Path: `${YOUR_DOCKER_COMPOSE_YML_PATH}/docker-compose.yml` Your docker-compose.yml file located directory.

Descript: To run **certbot-toy** by docker-compose which is need these envionment variables. Please adjust to the actual situation.

---

File: **user-config.sh**

Path: `${your_path}/certbot-toy/scripts/docker/config/user-config.sh`

Descript: Format as valild_domain["CERT_NAME"]="DOMAIN", that means `certbot --cert-name ${CERT_NAME} -d ${DOMAIN}`. The valild_domain is array, you should be defined domains list which is need Certbot certificates.

Parameter  | Feauture
--      | ----------
 valid_domain   | For example, <br> `valild_domain["example-a.com"]="*.example-a.com"` <br> `valild_domain["example-b.com"]="*.example-b.com"`

---

### docker-compose <span id="env">.env config usage</span>

```sh
#.env file

#nginx
WEB_ROOT_DIR=./www
NGINX_VERSION=1.16
NGINX_HTTP_HOST_PORT=80
NGINX_HTTPS_HOST_PORT=443
NGINX_CONF_DIR=./conf/nginx/conf.d
NGINX_CONF_FILE=./conf/nginx/nginx.conf
NGINX_SSL_CERTS_DIR=./conf/nginx/certs
NGINX_LOG_DIR=./log/nginx/

#certbot-toy
APP_DIR=/usr/local/opt/certbot-dns/
USER_CONFIG_DIR=/${YOUR_DOCKER_COMPOSE_WORKDIR}/certbot-toy/scripts/docker/config/
LETSENCRYPT_CONF_DIR=/${YOUR_DOCKER_COMPOSE_WORKDIR}/conf/letsencrypt/
LETSENCRYPT_WORK_DIR=/${YOUR_DOCKER_COMPOSE_WORKDIR}/data/letsencrypt/
LETSENCRYPT_LOG_DIR=/${YOUR_DOCKER_COMPOSE_WORKDIR}/log/letsencrypt/
ACCESS_KEY_ID=${YOUR_CLOUDFLARE_ACCESS_KEY_ID}
ACCESS_KEY_SECRET=${YOUR_CLOUDFLARE_ACCESS_KEY_SECRET}
ENDPOINT=${YOUR_CLOUDFLARE_ENDPOINT}
```

### docker-compose <span id="yml">yml config usage</span>
```sh
#docker-compose.yml file

version: "3.3"

services:
    nginx:
            env_file:
                    - ./.env
            image: nginx:${NGINX_VERSION}-alpine
            container_name: nginx
            volumes:
                    - ${WEB_ROOT_DIR}:/usr/share/nginx/html:rw
                    - ${NGINX_CONF_FILE}:/etc/nginx/nginx.conf:ro
                    - ${NGINX_CONF_DIR}:/etc/nginx/conf.d/:ro
                    - ${NGINX_SSL_CERTS_DIR}:/etc/nginx/certs/:ro
                    - ${NGINX_LOG_DIR}:/var/log/nginx/:rw
                    - ${LETSENCRYPT_CONF_DIR}:/etc/letsencrypt/:rw
            networks:
                    - lnmp-nginx
            ports:
                    - "${NGINX_HTTP_HOST_PORT}:80"
                    - "${NGINX_HTTPS_HOST_PORT}:443"
            restart:
                    always
    certbot:
            env_file:
                    - ./.env
            image: certbot-toy:latest
            container_name: certbot
            volumes:
                    - ${LETSENCRYPT_CONF_DIR}:/etc/letsencrypt/:rw
                    - ${LETSENCRYPT_WORK_DIR}:/var/lib/letsencrypt/:rw
                    - ${LETSENCRYPT_LOG_DIR}:/var/log/letsencrypt/:rw
                    - ${USER_CONFIG_DIR}:${APP_DIR}config/:rw
            environment:
                    - ACCESS_KEY_ID=${ACCESS_KEY_ID}
                    - ACCESS_KEY_SECRET=${ACCESS_KEY_SECRET}
                    - ENDPOINT=${ENDPOINT}
            stdin_open:
                    true
            tty:
                    true
            restart:
                    always
networks:
    lnmp-nginx:

```
