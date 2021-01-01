#!/bin/bash

# 或者使用以下包含文件代码
source ./certbot_config.sh

#注册用户
CERTBOT_REGISTER="--email ${certbot_email} --no-eff-email"

#指定证书
CERTBOT_CERT_NAME=unset

#指定域名
CERTBOT_DOMAIN=unset

#待执行命令
CERTBOT_COMMAND=unset

#使用信息
usage="
usage: ssh_certbot [-h|--help]
    <command> [<args>]

    These are common ssh_certbot commands used in various situations

    creat, renew, revoke and delete certificates
        certonly Re-creating and updating existing certificates
        renew    Force-renewal existing certificates
        revoke   Revoke certificates
        delete   Delete certificates

    manage certificates
        certificates     To view a list of the certificates Certbot knows about
        list-cert-live   To view a list of the live certificates in /etc/letsencrypt/live which in nginx docker directory

    manage domain
        list-cert-domain   To view a list of the domain which variable \`cert_domain_map\` is defined in ssh_certbot_config.sh

OPTIONS
    -n, --cert-name
        Set certbot --cert-name param, it is the certificates name
"

# Tips message
tipsMsg[0]='Invalid domain! Please edit variable `cert_domain_map` in file which name as ssh_certbot_config.sh'
tipsMsg[1]='Require command params! Please view usage through the option `-h`'
tipsMsg[2]='Require options params! Please view usage through the option `-h`'

#显示帮助信息
function usageFun(){
    echo "${usage}"
    exit 1
}

#列出证书及域名列表
function listCertDomainFun(){
    for key in ${!cert_domain_map[*]};do
        echo $key
        echo ${cert_domain_map[$key]}
    done
    exit 0
}

#校验证书名称有效性
function validCertNameFun(){
    if [[ ${cert_domain_map[$1]} ]]
        then
        CERTBOT_DOMAIN=${cert_domain_map[$1]}
        CERTBOT_CERT_NAME=$1
    else
        echo ${tipsMsg[0]}
        exit 1
    fi
}

function validOptionsFun(){
    local condition=unset

    if [[ $CERTBOT_CERT_NAME = unset ]]
        then
        condition=true
    fi

    if [[ $1 = "certonly" && $CERTBOT_DOMAIN = unset ]]
        then
        condition=true
    fi

    if [[ ${condition} = true ]]
        then
        echo ${tipsMsg[2]}
        exit 1
    fi
}

if [ $# -eq "0" ]
then
    echo ${tipsMsg[1]}
    exit 1
fi


# 定义解析参数
PARSED_ARGUMENTS=$(getopt -a -n ssh_certbot -o hn: -l help,cert-name: -- "$@")

# 上个命令的退出状态
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usageFun
fi

eval set -- "$PARSED_ARGUMENTS"

while :
do
  case "$1" in
    -h | --help)
        usageFun ;;
    -n | --cert-name)
        validCertNameFun $2;
        shift 2 ;;
    # -- means the end of the arguments; drop this, and break out of the while loop
    --) shift; break ;;
    # If invalid options were passed, then getopt should have reported an error,
    # which we checked as VALID_ARGUMENTS when getopt was called...
    *) echo "Unexpected option: $1 - this should not happen. line 106"
       usageFun ;;
  esac
done


#颁发证书
certbot_command_certonly="certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --agree-tos --cert-name ${CERTBOT_CERT_NAME} -d ${CERTBOT_DOMAIN} "

#强制更新证书
certbot_command_renew="certbot renew --force-renewal --cert-name ${CERTBOT_CERT_NAME}"

#吊销证书
certbot_command_revoke="certbot revoke --cert-name ${CERTBOT_CERT_NAME}"

#删除证书
certbot_command_delete="certbot delete --cert-name ${CERTBOT_CERT_NAME}"

#查询证书
certbot_command_certificates="certbot certificates"

#certbot前置脚本
CERTBOT_PRE_COMMAND="/usr/bin/docker-compose -f ${docker_compose_yml} run "

#certbot后置脚本
CERTBOT_POST_COMMAND=" && /usr/bin/docker-compose -f ${docker_compose_yml} kill -s SIGH\UP nginx"

#查询nginx-live证书
NGINX_LIVE_COMMAND="/usr/bin/docker-compose exec nginx ls -la /etc/letsencrypt/live"


for commandVar in $@
do
    case "$commandVar" in
        "certonly")
            validOptionsFun "certonly"
            SELL_COMMAND=${CERTBOT_PRE_COMMAND}${certbot_command_certonly}${CERTBOT_POST_COMMAND}; break ;;
        "renew")
            validOptionsFun "renew"
            SELL_COMMAND=${CERTBOT_PRE_COMMAND}${certbot_command_renew}${CERTBOT_POST_COMMAND}; break ;;
        "revoke")
            validOptionsFun "revoke"
            SELL_COMMAND=${CERTBOT_PRE_COMMAND}${certbot_command_revoke}${CERTBOT_POST_COMMAND}; break ;;
        "delete")
            validOptionsFun "delete"
            SELL_COMMAND=${CERTBOT_PRE_COMMAND}${certbot_command_delete}${CERTBOT_POST_COMMAND}; break ;;
        "certificates")
            SELL_COMMAND=${CERTBOT_PRE_COMMAND}${certbot_command_certificates}; break ;;
        "list-cert-live")
            SELL_COMMAND=${NGINX_LIVE_COMMAND}; break ;;
        "list-cert-domain")
            listCertDomainFun; break ;;
        *)
            echo "Unexpected option: $1 - this should not happen. line 150"
            usageFun ;;
    esac
done

# echo ${SELL_COMMAND}
eval ${SELL_COMMAND}
