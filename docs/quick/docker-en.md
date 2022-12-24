## Quick start - docker

Let's assume that you have completed configuration [docker config](../config/docker-en.md), CD to the workdir and into certbot-toy directory。

```sh
cd ${your_path} && cd certbot-toy
```

Please select the corresponding step according to your actual situation.

### step 1 - init third party dns-plugins [optional]

This command is to init third party dns-plugins, it include aliyun Cloud DNS.

Don't forget to complete the configuration `init-config.sh` file, **we need these envionment variables**.

- 1.1 Actually we have offered the go build binary file in the `${your_path}/certbot-toy/scripts/docker/bin/` directory, **you can skip the init step**.

```sh
#1.1
bash main.sh init
```

### step 2 - build certbot-toy docker image [required]

Please select one of the methods in **2.1** or **2.2** to get the certbot-toy image.

- 2.1 This command is to build docker images, the certbot-toy is integrated EFF's Certbot with third party dns plugins.

```sh
#2.1
bash main.sh build
```

- 2.2 This command is to pull the "certbot-toy:latest” which is download from hub.docker.com online origin.

```sh
#2.2
docker pull xubeijun/certbot-toy

```

Below command help you to view this docker image which is named **certbot-toy**.
```sh
docker images

```

### step 3 - run certbot-toy docker image [required]

Please select one of the methods in **3.1** or **3.2** to run the certbot-toy image.

This command is to run the docker images which is named certbot-toy.

- 3.1 Don't forget to complete the configuration `user.env` file, **we need these envionment variables**.

```sh
#3.1
#match to 2.1 step `bash main.sh build`
bash main.sh run
```

- 3.2 This command is to run the "certbot-toy:latest” which is download from hub.docker.com online origin.

```sh
#3.2
#match to 2.2 step `docker pull xubeijun/certbot-toy`
docker run \
--name certbot \
-itd \
-v ${LETSENCRYPT_CONF_DIR}:/etc/letsencrypt \
-v ${LETSENCRYPT_WORK_DIR}:/var/lib/letsencrypt \
-v ${LETSENCRYPT_LOG_DIR}:/var/log/letsencrypt \
-v ${USER_CONFIG_DIR}:/usr/local/opt/certbot-dns/config/ \
-e ACCESS_KEY_ID=${ACCESS_KEY_ID} \
-e ACCESS_KEY_SECRET=${ACCESS_KEY_SECRET} \
-e ENDPOINT=${ENDPOINT} \
-e LETSENCRYPT_USER_EMAIL=${LETSENCRYPT_USER_EMAIL} \
xubeijun/certbot-toy:latest

```

Below command help you to view this docker container list, you will see it which one is named **certbot**.

```sh
docker container ls -a

```

### congratulations

Don't forget to complete the configuration `user-config.sh` file, **we need these envionment variables**.

You can modify the configuration file on demand at any time.

Lists of the valid domain config which is defined in user-config.sh file.

```sh
docker exec certbot certbot-toy manage -l
```
