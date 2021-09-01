## Quick start - docker

Let's assume that you have completed configuration [docker config](./docs/config/docker-en.md), CD to the workdir and into certbot-toy directory。

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

Below command help you to view this docker image which is named **certbot-toy**.
```sh
docker images

```

### step 3 - run certbot-toy docker image [required]

This command is to run the docker images which is named certbot-toy.

Don't forget to complete the configuration `user.env` file, **we need these envionment variables**.

```sh
bash main.sh run
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
