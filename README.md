# certbot_toy
Offer efficiently command to manage letsencrypt SSL wildcard certificates base on docker compose.

基于docker compose提供高效的命令去管理letsencrypt的SSL通配符证书。

### 目录结构
Director  | Feauture
--      | ----------
 docker-env   | docker compose配置
 scripts | certbot脚本

### 配置文件
Director  | Feauture
--      | ----------
 docker-env/.env   | docker配置文件
 scripts/certbot_config.sh | certbot配置文件

### 获取帮助信息
获取用例信息

```cmd
cd ./certbot-toy/scripts && ./certbot_main.sh -h
```

## 立即开始——只需要6步
请根据自身实际情况，修改docker yml配置文件，及certbot配置文件。

### step1
填写“docker配置文件”中的变量
「MYSQL_ROOT_PASSWORD、MYSQL_USER_NAME、MYSQL_USER_PASSWORD、REDIS_PASS_WORD」

允许docker compose命令如代码示例。“需要您的服务器已安装好docker和docker compose。”

```cmd
cd ./certbot-toy/docker-env && docker-compose up -d
```

### step2
生成 迪菲-赫尔曼密钥交换

```
cd ./certbot-toy/docker-env && openssl dhparam -out ./conf/nginx/certs/dhparam-2048.pem 2048
```

### step3
填写“certbot配置文件”的变量
「certbot_email、cert_domain_map」

新建通配符证书

```cmd
cd ./certbot-toy/scripts && ./certbot_main.sh certonly -n example.com
```

### step4
当提示配置对应域名的TXT记录时，请在域名供应商后台，新增TXT记录，并填写对应的标识码

验证TXT记录的DNS是否生效（macOS系统）
```cmd
dig TXT _acme-challenge.example.com
```

### step5
按提示确定生成证书

查看live证书
```
cd ./certbot-toy/scripts && ./certbot_main.sh list-cert-live
```

### step6

如果缺失执行权限，请执行以下命令进行授权
```cmd
cd ./certbot-toy/scripts && chmod +x ./certbot_main.sh
```

定时执行续期证书（15天）
```cmd
crontab -e

# 0 0 */15 * * /home/{your director}/certbot-toy/scripts/certbot_main.sh renew -n example.com >> /home/{your director}/certbot-toy/docker-env/log/letsencrypt/cron.log 2>&1
```
