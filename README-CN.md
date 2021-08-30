[English](README.md) | 简体中文


<h1 align="center">certbot-toy</h1>
这个程序的目的是生成**certbot-toy**docker镜像，便于管理certbot证书。
非Certbot官方生成，其dns插件目前已集成支持阿里云dns。

## 必要条件

- Go 1.14.x or later.
- GNU bash 5.1.x or later.
- Docker 18.09.x or later.

## 安装

方式 1: 使用受密码保护的SSH密钥。
```sh
git clone git@github.com:xubeijun/certbot-toy.git
```

方式 2: 通过网络URL使用Git下载。
```sh
git clone https://github.com/xubeijun/certbot-toy.git
```

## 配置

文件: **init-config.sh**

路径: `${your_path}/certbot-toy/scripts/dns-plugins/init-config.sh`

描述: Go build第三方插件需要以下参数。

参数  | 功能
--      | ----------
 MACHINE_GOOS   | 使用`go env`命令在您的机器上查看GOOS参数对应的值
 MACHINE_GOARCH | 使用`go env`命令在您的机器上查看GOARCH参数对应的值


文件: **user.env**

路径: `${your_path}/certbot-toy/scripts/docker/config/user.env`

描述: 运行**certbot-toy**的docker镜像服务需要以下参数。

参数  | 功能
--      | ----------
 USER_CONFIG_DIR   | 该值为绝对路径，将挂载到docker容器中的`${APP_DIR}config/`目录。
 LETSENCRYPT_CONF_DIR   | 该值为绝对路径，将挂载到docker容器中的`/etc/letsencrypt`目录。
 LETSENCRYPT_WORK_DIR   | 该值为绝对路径，将挂载到docker容器中的`/var/lib/letsencrypt`目录。
 LETSENCRYPT_LOG_DIR   | 该值为绝对路径，将挂载到docker容器中的`/var/log/letsencrypt`目录。
 ACCESS_KEY_ID   | 用户标识，将用于您的云服务商dns接口调用，通过您的云服务商自助服务获取。
 ACCESS_KEY_SECRET   | 用户密钥，将用于您的云服务商dns接口调用，通过您的云服务商自助服务获取。
 ENDPOINT   | API服务端地址，将用于您的云服务商dns接口调用，通过您的云服务商自助服务获取。

文件: **user-config.sh**

路径: `${your_path}/certbot-toy/scripts/docker/config/user-config.sh`

描述: Format as valild_domain["CERT_NAME"]="DOMAIN", that means `certbot --cert-name ${CERT_NAME} -d ${DOMAIN}`.

参数  | 功能
--      | ----------
 valid_domain   | For example, `valild_domain["example.com"]="*.example.com"`.

 ---

## 用例

获取该脚本更多信息及学习它的命令。

```sh
cd ${your_path}/certbot-toy/
bash main.sh help
```

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

该命令执行certbot-toy镜像的容器服务，您将会看到它的用法说明。

不要忘记完成配置`user-config.sh`文件, **我们需要这些环境变量**.

```sh
docker exec -it certbot certbot-toy -h
```

---

## 恭喜

祝您使用certbot-toy时能有一个有趣的体验。

e.g. 查看更多 [certbot-toy 用法说明](./scripts/docker/docs/help/manage-zh-Hans-CN.txt)

```sh
docker exec -it certbot certbot-toy -h
```

e.g. 打印certbot生成的证书。

```sh
docker exec -it certbot certbot-toy manage -c
```

e.g. 列出有效的域名，其在user-config.sh文件中定义。

```sh
docker exec -it certbot certbot-toy manage -l
```

e.g. 重新创建和更新现有证书。

```sh
docker exec -it certbot certbot-toy manage -a certonly -d example.com -p aliyun
```

e.g. 强制更新现有证书。

```sh
docker exec -it certbot certbot-toy manage -a renew
```

e.g. 撤销证书。

```sh
docker exec -it certbot certbot-toy manage -a revoke -d example.com
```

e.g. 删除证书。

```sh
docker exec -it certbot certbot-toy manage -a delete -d example.com
```

## 关注
关注同名微博、公众号**续杯君**，获得更多资讯。
