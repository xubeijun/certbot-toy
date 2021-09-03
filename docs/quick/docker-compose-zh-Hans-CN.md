## 快速开始 - docker-compose

请根据您的实际情况选择相应的步骤。

假定您已完成[docker-compose 配置](../config/docker-compose-zh-Hans-CN.md)，并且您CD至工作目录中的certbot-toy。

```sh
cd ${your_path} && cd certbot-toy
```

### 步奏 1 - 初始化第三方dns插件 [可选]

该命令将下载依赖并生成第三方插件，当前包含阿里云dns。

不要忘记完成配置`init-config.sh`文件, **我们需要这些环境变量**.

- 1.1 实际上我们已经提供了初始化后生成的第三方go二进制插件，其文件目录位于`${your_path}/certbot-toy/scripts/docker/bin/`， **您可以跳过初始化这一步奏**.

```sh
#1.1
bash main.sh init
```

### 步奏 2 - 生成certbot-toy的docker镜像服务 [必选]

请选择**2.1**或者**2.2**中一种方式用于获取certbot-toy镜像。

- 2.1 该命令生成docker镜像服务，这个certbot-toy是集成了第三方dns插件的certbot镜像。

```sh
#2.1
bash main.sh build
```

- 2.2 该命令拉取hub.docker.com上certbot-toy:latest版本的镜像

```sh
#2.2
docker pull xubeijun/certbot-toy

```

需要进入您的docker-compose.yml文件所在目录

```sh
cd ${YOUR_DOCKER_COMPOSE_YML_PATH}
```

以下命令帮助您查看当前docker环境下的镜像列表，您将会看到其中一个镜像名称为**certbot-toy**。
```sh
docker-compose images

```

### 步奏 3 - 运行certbot-toy镜像的容器服务 [必选]

不要忘记完成`.env`和`docker-compose.yml`文件的配置, **我们需要这些环境变量**.

需要进入您的docker-compose.yml文件所在目录

```sh
cd ${YOUR_DOCKER_COMPOSE_YML_PATH}
```

- 3.1 该命令运行certbot-toy镜像的容器服务。

```sh
#3.1
docker-compose up --no-deps -d certbot
```

以下命令帮助您查看当前docker环境下的容器列表，您将会看到其中一个容器名称为**certbot**.
```sh
docker-compose ps

```

### 恭喜

不要忘记完成`user-config.sh`文件的配置, **我们需要这些环境变量**。您可以随时按需，对该配置进行“更删改”的操作。

需要进入您的docker-compose.yml文件所在目录

```sh
cd ${YOUR_DOCKER_COMPOSE_YML_PATH}
```

恭喜您，至此可以使用certbot-toy容器来高效管理Certbot证书！

执行该命令,将列出有效的域名配置。

```sh
docker-compose exec certbot certbot-toy manage -l
```