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

## 快速开始 - 只要3步

请根据您的实际情况选择下列中的一种方式。

- [docker 快速开始](./docs/quick/docker-zh-Hans-CN.md)

- [docker-compose 快速开始](./docs/quick/docker-compose-zh-Hans-CN.md)

---


## 使用示例

请根据您的实际情况选择使用下列中的一项。

- [docker 使用示例](./docs/usage/docker-zh-Hans-CN.md)

- [docker-compose 使用示例](./docs/usage/docker-compose-zh-Hans-CN.md)


## 关注
关注同名[微博](https://weibo.com/xubeijun)、公众号、[哔哩哔哩](https://space.bilibili.com/490987374/)**续杯君**，获得更多资讯。
