English | [简体中文](README-CN.md)


<h1 align="center">certbot-toy</h1>
The purpose of this program is to generate certbot-toy which is a docker images for managing Certbot certificates.
Unofficial build of EFF's Certbot with its plugin for doing DNS challenges using aliyun Cloud DNS.

## Requirements

- Go 1.14.x or later.
- GNU bash 5.1.x or later.
- Docker 18.09.x or later.

## Installation

Method 1: Use a password-protected SSH key.
```sh
git clone git@github.com:xubeijun/certbot-toy.git
```

Method 2: Use Git or checkout with SVN using the web URL.
```sh
git clone https://github.com/xubeijun/certbot-toy.git
```

## Config

File: **init-config.sh**

Path: `${your_path}/certbot-toy/scripts/dns-plugins/init-config.sh`

Descript: Go build third party dns-plugins need these parameters.

Parameter  | Feauture
--      | ----------
 MACHINE_GOOS   | go env command to view the values of GOOS on your machine
 MACHINE_GOARCH | go env command to view the values of GOARCH on your machine


File: **user.env**

Path: `${your_path}/certbot-toy/scripts/docker/config/user.env`

Descript: Run certbot-toy of the docker image need these envionment variables.

Parameter  | Feauture
--      | ----------
 USER_CONFIG_DIR   | it is absolute path and mounted to `${APP_DIR}config/` in docker directory.
 LETSENCRYPT_CONF_DIR   | it is absolute path and mounted to `/etc/letsencrypt` in docker directory.
 LETSENCRYPT_WORK_DIR   | it is absolute path and mounted to `/var/lib/letsencrypt` in docker directory.
 LETSENCRYPT_LOG_DIR   | it is absolute path and mounted to `/var/log/letsencrypt` in docker directory.
 ACCESS_KEY_ID   | it is used in your third part dns plugin sdk and get it from your clound service.
 ACCESS_KEY_SECRET   | it is used in your third part dns plugin sdk and get it from your clound service.
 ENDPOINT   | it is used in your third part dns plugin sdk and get it from your clound service.

File: **user-config.sh**

Path: `${your_path}/certbot-toy/scripts/docker/config/user-config.sh`

Descript: Format as valild_domain["CERT_NAME"]="DOMAIN", that means `certbot --cert-name ${CERT_NAME} -d ${DOMAIN}`.

Parameter  | Feauture
--      | ----------
 valid_domain   | For example, `valild_domain["example.com"]="*.example.com"`.

 ---

## Usage

Get more information about this script and learn its command.

```sh
cd ${your_path}/certbot-toy/
bash main.sh help
```

## Quick Examples

Please select the corresponding step according to your actual situation.

### step 1 - init third party dns-plugins
This command is to init third party dns-plugins, it include aliyun Cloud DNS.

Don't forget to complete the configuration `init-config.sh` file, **we need these envionment variables**.

Actually we have offered the go build binary file in the `${your_path}/certbot-toy/scripts/docker/bin/` directory, **you can skip the init step**.

```sh
bash main.sh init
```

### step 2 - build certbot-toy docker image
This command is to build docker images, the certbot-toy is integrated EFF's Certbot with third party dns plugins.

```sh
bash main.sh build
```

Below command help you to view this docker image which is named **certbot-toy**.
```sh
docker images

```

### step 3 - run certbot-toy docker image
This command is to run the docker images which is named certbot-toy.

Don't forget to complete the configuration `user.env` file, **we need these envionment variables**.

```sh
bash main.sh run
```

Below command help you to view this docker container which is named **certbot**.
```sh
docker container ls -a

```

### setp 4 - exec certbot-toy docker container

This command is to exec the docker container which is named certbot-toy, you will see the usage.

Don't forget to complete the configuration `user-config.sh` file, **we need these envionment variables**.

```sh
docker exec -it certbot certbot-toy -h
```

---

## Congratulations

Have a fun experience with certbot-toy.

e.g. View more [certbot-toy usage](./scripts/docker/docs/help/manage.txt)

```sh
docker exec -it certbot certbot-toy -h
```

e.g. print the certificates which certbot knows about.

```sh
docker exec -it certbot certbot-toy manage -c
```

e.g. Lists of the valid domain which is defined in user-config.sh file.

```sh
docker exec -it certbot certbot-toy manage -l
```

e.g. Re-creating and updating existing certificates

```sh
docker exec -it certbot certbot-toy manage -a certonly -d example.com -p aliyun
```

e.g. Force-renewal existing certificates

```sh
docker exec -it certbot certbot-toy manage -a renew
```

e.g. Revoke certificates

```sh
docker exec -it certbot certbot-toy manage -a revoke -d example.com
```

e.g. Delete certificates

```sh
docker exec -it certbot certbot-toy manage -a delete -d example.com
```

## Follow me
Follow my Weibo, WeChat Official Account **续杯君** for more information.
