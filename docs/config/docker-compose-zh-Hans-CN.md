## 配置 - docker-compose

文件: **init-config.sh**

路径: `${your_path}/certbot-toy/scripts/dns-plugins/init-config.sh`

描述: Go build第三方插件需要以下参数。

参数  | 功能
--      | ----------
 MACHINE_GOOS   | 使用`go env`命令在您的机器上查看GOOS参数对应的值
 MACHINE_GOARCH | 使用`go env`命令在您的机器上查看GOARCH参数对应的值

---

文件: **.env** [配置示例](#env)

路径: `${YOUR_DOCKER_COMPOSE_ENV_PATH}/.env` 您的docker-compose.yml所需.env的文件所在目录

描述: 运行**certbot-toy**的docker镜像服务需要以下参数。

参数  | 功能
--      | ----------
 APP_DIR   | 该值为绝对路径，代表着容器的WORKDIR工作目录。<br>其默认值为`/usr/local/opt/certbot-dns/`，该默认值与`${your_path}/certbot-toy/scripts/docker/config/sys.env`中的APP_DIR保持一致。
 USER_CONFIG_DIR   | 该值为绝对路径，将挂载到docker容器中的`${APP_DIR}config/`目录。
 USER_CONFIG_DIR   | 该值为绝对路径，将挂载到docker容器中的`${APP_DIR}config/`目录。
 LETSENCRYPT_CONF_DIR   | 该值为绝对路径，将挂载到docker容器中的`/etc/letsencrypt`目录。
 LETSENCRYPT_WORK_DIR   | 该值为绝对路径，将挂载到docker容器中的`/var/lib/letsencrypt`目录。
 LETSENCRYPT_LOG_DIR   | 该值为绝对路径，将挂载到docker容器中的`/var/log/letsencrypt`目录。
 ACCESS_KEY_ID   | 用户标识，将用于您的云服务商dns接口调用，通过您的云服务商自助服务获取。
 ACCESS_KEY_SECRET   | 用户密钥，将用于您的云服务商dns接口调用，通过您的云服务商自助服务获取。
 ENDPOINT   | API服务端地址，也称Zone ID，将用于您的云服务商dns接口调用，通过您的云服务商自助服务获取。

---

文件: **docker-compose.yml** [配置示例](#yml)

路径: `${YOUR_DOCKER_COMPOSE_YML_PATH}/docker-compose.yml` 您的docker-compose.yml文件所在目录

描述: 通过docker-compose运行**certbot-toy**镜像服务需要该配置。请根据实际情况进行调整。

---

文件: **user-config.sh**

路径: `${your_path}/certbot-toy/scripts/docker/config/user-config.sh`

描述: 格式如`valild_domain["CERT_NAME"]="DOMAIN"`，指向`certbot --cert-name ${CERT_NAME} -d ${DOMAIN}`。valild_domain是数组，您可在此处定义需要获取证书的域名列表。

参数  | 功能
--      | ----------
 valid_domain   | 示例： <br> `valild_domain["example-a.com"]="*.example-a.com"` <br> `valild_domain["example-b.com"]="*.example-b.com"`

---

### docker-compose <span id="env">.env配置示例</span>

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

### docker-compose <span id="yml">yml配置示例</span>
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