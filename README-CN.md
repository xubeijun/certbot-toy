[English](README.md) | 简体中文


<h1 align="center">certbot-toy</h1>
这个程序的目的是生成**certbot-toy**docker镜像，便于管理certbot证书。
非Certbot官方生成，其dns插件目前已集成支持阿里云dns。

## 必要条件

- Go 1.14.x or later.
- GNU bash 5.1.x or later.
- Docker 18.09.x or later.
- Docker-compose 1.18.x or later.

## 安装

首先需要进入您的工作目录
```sh
cd ${your_path}
```

方式 1: 使用受密码保护的SSH密钥。
```sh
git clone git@github.com:xubeijun/certbot-toy.git
```

方式 2: 通过网络URL使用Git下载。
```sh
git clone https://github.com/xubeijun/certbot-toy.git
```

## 配置

请根据您的实际情况选择配置下列中的一项。

- [docker 配置](./docs/config/docker-zh-Hans-CN.md)

- [docker-compose 配置](./docs/config/docker-compose-zh-Hans-CN.md)

 ---

## 快速开始

请根据您的实际情况选择相应的步骤。

### 步奏 1 - 初始化第三方dns插件

该命令将下载依赖并生成第三方插件，当前包含阿里云dns。

不要忘记完成配置`init-config.sh`文件, **我们需要这些环境变量**.

实际上我们已经提供了初始化后生成的第三方go二进制插件，其文件目录位于`${your_path}/certbot-toy/scripts/docker/bin/`， **您可以跳过初始化这一步奏**.

```sh
bash main.sh init
```

### 步奏 2 - 生成certbot-toy的docker镜像服务

该命令生成docker镜像服务，这个certbot-toy是集成了第三方dns插件的certbot镜像。

```sh
bash main.sh build
```

以下命令帮助您查看当前docker环境下的镜像列表，您将会看到其中一个镜像名称为**certbot-toy**。
```sh
docker images

```

### 步奏 3 - 运行certbot-toy镜像的容器服务

该命令运行certbot-toy镜像的容器服务。

不要忘记完成配置`user.env`文件, **我们需要这些环境变量**.

```sh
bash main.sh run
```

以下命令帮助您查看当前docker环境下的容器列表，您将会看到其中一个容器名称为**certbot**.
```sh
docker container ls -a

```

### 步奏 4 - 执行certbot-toy镜像的容器服务

不要忘记完成配置`user-config.sh`文件, **我们需要这些环境变量**.

恭喜您，至此可以使用certbot-toy容器来高效管理Certbot证书！

执行该命令将获取certbot-toy的用法说明。

```sh
docker exec -it certbot certbot-toy -h
```

---


## 使用示例

祝您使用certbot-toy时能有一个有趣的体验。

请根据您的实际情况选择使用下列中的一项。

- [docker 使用示例](./docs/usage/docker-zh-Hans-CN.md)

- [docker-compose 使用示例](./docs/usage/docker-compose-zh-Hans-CN.md)


## 关注
关注同名微博、公众号**续杯君**，获得更多资讯。
