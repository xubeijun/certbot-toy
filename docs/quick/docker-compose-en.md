## Quick start - docker-compose

Let's assume that you have completed configuration [docker-compose config](./docs/config/docker-compose-en.md), CD to the workdir and into certbot-toy directory。

```sh
cd ${your_path} && cd certbot-toy
```

Please select the corresponding step according to your actual situation.

### step 1 - init third party dns-plugins [optional]

This command is to init third party dns-plugins, it include aliyun Cloud DNS.

Don't forget to complete the configuration `init-config.sh` file, **we need these envionment variables**.

Actually we have offered the go build binary file in the `${your_path}/certbot-toy/scripts/docker/bin/` directory, **you can skip the init step**.

```sh
bash main.sh init
```

### step 2 - build certbot-toy docker image [required]

This command is to build docker images, the certbot-toy is integrated EFF's Certbot with third party dns plugins.

```sh
bash main.sh build
```

You need to go to the directory where your docker-compose.yml file is located.

```sh
cd ${YOUR_DOCKER_COMPOSE_YML_PATH}
```

Below command help you to view this docker image which is named **certbot-toy**.
```sh
docker-compose images

```

### step 3 - run certbot-toy docker image [required]

Don't forget to complete the configuration `.env` and `docker-compose.yml` file, **we need these envionment variables**.

You need to go to the directory where your docker-compose.yml file is located.

```sh
cd ${YOUR_DOCKER_COMPOSE_YML_PATH}
```

This command is to run the docker images which is named certbot-toy.

```sh
docker-compose up --no-deps -d certbot
```

Below command help you to view this docker container list, you will see it which one is named **certbot**.

```sh
docker-compose ps

```

### congratulations

Don't forget to complete the configuration `user-config.sh` file, **we need these envionment variables**.

You can modify the configuration file on demand at any time.

You need to go to the directory where your docker-compose.yml file is located.

```sh
cd ${YOUR_DOCKER_COMPOSE_YML_PATH}
```

Lists of the valid domain config which is defined in user-config.sh file.

```sh
docker-compose exec certbot certbot-toy manage -l
```
