
## 配置 - docker

文件: **init-config.sh**

路径: `${your_path}/certbot-toy/scripts/dns-plugins/init-config.sh`

描述: Go build第三方插件需要以下参数。

参数  | 功能
--      | ----------
 MACHINE_GOOS   | 使用`go env`命令在您的机器上查看GOOS参数对应的值
 MACHINE_GOARCH | 使用`go env`命令在您的机器上查看GOARCH参数对应的值

---

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
 LETSENCRYPT_USER_EMAIL   | 用户邮箱，用于注册和通知证书信息变更的邮件地址。

---

文件: **user-config.sh**

路径: `${your_path}/certbot-toy/scripts/docker/config/user-config.sh`

描述: 格式如`valild_domain["CERT_NAME"]="DOMAIN"`，指向`certbot --cert-name ${CERT_NAME} -d ${DOMAIN}`。valild_domain是数组，您可在此处定义需要获取证书的域名列表。

参数  | 功能
--      | ----------
 valid_domain   | 示例： <br> `valild_domain["example-a.com"]="*.example-a.com"` <br> `valild_domain["example-b.com"]="*.example-b.com"`