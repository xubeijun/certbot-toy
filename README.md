English | [简体中文](README-CN.md)


<h1 align="center">certbot-toy</h1>
The purpose of this program is to generate certbot-toy which is a docker images for managing Certbot certificates.
Unofficial build of EFF's Certbot with its plugin for doing DNS challenges using aliyun Cloud DNS.

## Requirements

- Go 1.14.x or later.
- GNU bash 5.1.x or later.
- Docker 18.09.x or later.
- docker-compose 1.18.x or later.

## Installation

First you need to go to the work directory.
```sh
cd ${your_path}
```

Method 1: Use a password-protected SSH key.
```sh
git clone git@github.com:xubeijun/certbot-toy.git
```

Method 2: Use Git or checkout with SVN using the web URL.
```sh
git clone https://github.com/xubeijun/certbot-toy.git
```

## Config

Please select the corresponding config according to your actual situation.

- [docker config](./docs/config/docker-en.md)

- [docker-compose config](./docs/config/docker-compose-en.md)

 ---

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

## Usage

Have a fun experience with certbot-toy.

Please select the corresponding usage according to your actual situation.

- [docker usage](./docs/usage/docker-en.md)

- [docker-compose usage](./docs/usage/docker-compose-en.md)

## Follow me
Follow my Weibo, WeChat Official Account **续杯君** for more information.
