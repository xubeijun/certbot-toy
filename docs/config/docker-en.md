
## config - docker

File: **init-config.sh**

Path: `${your_path}/certbot-toy/scripts/dns-plugins/init-config.sh`

Descript: Go build third party dns-plugins need these parameters.

Parameter  | Feauture
--      | ----------
 MACHINE_GOOS   | go env command to view the values of GOOS on your machine
 MACHINE_GOARCH | go env command to view the values of GOARCH on your machine

---

File: **user.env**

Path: `${your_path}/certbot-toy/scripts/docker/config/user.env`

Descript: Run certbot-toy of the docker image need these envionment variables.

Parameter  | Feauture
--      | ----------
 USER_CONFIG_DIR   | it is absolute path and mounted to `${APP_DIR}config/` in docker directory.
 LETSENCRYPT_CONF_DIR   | it is absolute path and mounted to `/etc/letsencrypt` in docker directory.
 LETSENCRYPT_WORK_DIR   | it is absolute path and mounted to `/var/lib/letsencrypt` in docker directory.
 LETSENCRYPT_LOG_DIR   | it is absolute path and mounted to `/var/log/letsencrypt` in docker directory.
 ACCESS_KEY_ID   | it is the Cloudflare api key id and used in your third part dns plugin sdk and get it from your clound service.
 ACCESS_KEY_SECRET   | it is the Cloudflare api key secret and used in your third part dns plugin sdk and get it from your clound service.
 ENDPOINT   | it is the Cloudflare zone id and used in your third part dns plugin sdk and get it from your clound service.
 LETSENCRYPT_USER_EMAIL   | it is user email and used for registration and recovery contact.

---

File: **user-config.sh**

Path: `${your_path}/certbot-toy/scripts/docker/config/user-config.sh`

Descript: Format as valild_domain["CERT_NAME"]="DOMAIN", that means `certbot --cert-name ${CERT_NAME} -d ${DOMAIN}`. The valild_domain is array, you should be defined domains list which is need Certbot certificates.

Parameter  | Feauture
--      | ----------
 valid_domain   | For example, <br> `valild_domain["example-a.com"]="*.example-a.com"` <br> `valild_domain["example-b.com"]="*.example-b.com"`
