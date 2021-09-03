## 使用示例 - docker

e.g. 查看更多 [certbot-toy 用法说明](../../scripts/docker/docs/help/manage-zh-Hans-CN.txt)

```sh
#docker
docker exec certbot certbot-toy -h
```

e.g. 打印certbot生成的证书。

```sh
#docker
docker exec certbot certbot-toy manage -c
```

e.g. 列出有效的域名配置，其在user-config.sh文件中定义。

```sh
#docker
docker exec certbot certbot-toy manage -l
```

e.g. 重新创建和更新现有证书。

```sh
#docker
docker exec certbot certbot-toy manage -a certonly -d example.com -p aliyun
```

e.g. 强制更新现有证书。

```sh
#docker
docker exec certbot certbot-toy manage -a renew
```

e.g. 撤销证书。

```sh
#docker
docker exec certbot certbot-toy manage -a revoke -d example.com
```

e.g. 删除证书。

```sh
#docker
docker exec certbot certbot-toy manage -a delete -d example.com
```

e.g. 创建、更新、撤销、删除证书并重启nginx。
```sh
#docker-compose

#格式
${your_certbot_command} && docker exec nginx nginx -s reload

#举例说明
docker exec certbot certbot-toy manage -a certonly -d example.com -p aliyun && docker exec nginx nginx -s reload
```

e.g. 每隔15天自动强制更新现有证书，并重启nginx。

**注意**，请将下列脚本中的`${LETSENCRYPT_LOG_DIR}`替换为您在user.env配置文件中定义的值。

```sh
#docker
crontab -l > conf && echo "0 0 */15 * * docker exec certbot certbot-toy manage -a certonly renew  >> ${LETSENCRYPT_LOG_DIR}cron.log 2>&1 && docker exec nginx nginx -s reload" >> conf && crontab conf && rm -f conf
```
