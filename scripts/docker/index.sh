#!/bin/bash

source ./docs/help.sh
source ./docs/error.sh
source ./config/user-config.sh
source ./config/sys-config.sh

#证书名称,通用域名,dns插件,命令内容,操作类型
unset CERT_NAME DOMAIN DNS_PLUGIN SHELL_COMMAND ACTION_TYPE

#有效域名列表
function listValidDomain(){
    for key in ${!valid_domain[*]};do
        echo "certificate name: $key"
        echo "wildcard-ssl-certificate: ${valid_domain[$key]}"
        echo ""
    done
}

#校验证书名称有效性
function validDomain(){
    if [[ ${valid_domain[$1]} ]]
        then
        DOMAIN=${valid_domain[$1]}
        CERT_NAME=$1
    else
        error "invalidDomain"
    fi
}

#校验dns插件有效性
function validPlugin(){
    if [[ ${valid_dns_plugins[@]} =~ $1 ]]
        then
        DNS_PLUGIN="$1"
        echo $DNS_PLUGIN > /tmp/DNS_PLUGIN
    else
        error "invalidDns"
    fi
}

#根据action类型生成命令内容
function actionCommand(){
    case "${ACTION_TYPE}" in
        "certonly")
            if [[ -z ${CERT_NAME+x} || -z ${DOMAIN+x} || -z ${DNS_PLUGIN+x} ]]
            then
                error "requireOption"
            fi
            SHELL_COMMAND="certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --agree-tos --cert-name ${CERT_NAME} -d ${DOMAIN}  --manual-auth-hook ${APP_DIR}hooks/auth.sh --manual-cleanup-hook ${APP_DIR}hooks/cleanup.sh";;
        "renew")
            SHELL_COMMAND="certbot renew";;
        "revoke")
            if [[ -z ${CERT_NAME+x} ]]
            then
                error "requireOption"
            fi
            SHELL_COMMAND="certbot revoke --cert-name ${CERT_NAME}";;
        "delete")
            if [[ -z ${CERT_NAME+x} ]]
            then
                error "requireOption"
            fi
            SHELL_COMMAND="certbot delete --cert-name ${CERT_NAME}";;
        *) echo "Unexpected action: ${ACTION_TYPE} - this should not happen."
           help ;;
    esac
}

#程序主入口
function main(){
    if [[ $# -eq "0" ]]
    then
        error "requireOption"
    fi

    # 定义解析参数
    PARSED_ARGUMENTS=$(getopt -a -n manage-certs -o cla:d:p: -l certs,list,action:,domain:,plugin: -- "$@")  

    eval set -- "$PARSED_ARGUMENTS"

    while :
    do
      case "$1" in
        "-a" | "--action")
            case "$2" in
                "certonly")
                ACTION_TYPE="certonly";;
                "renew")
                ACTION_TYPE="renew";;
                "revoke")
                ACTION_TYPE="revoke";;
                "delete")
                ACTION_TYPE="delete";;
                *) echo "Unexpected action: $2 - this should not happen."
                   help ;;
            esac
            shift 2;;
        "-d" | "--domain")
            validDomain $2
            shift 2;;
        "-p" | "--plugin")
            validPlugin $2;
            shift 2 ;;
        "-l" | "--list")
            SHELL_COMMAND=listValidDomain
            shift 1; break;;
        "-c" | "--certs")
            SHELL_COMMAND="certbot certificates";
            shift 1; break;;
        --) shift; break ;;
        *) echo "Unexpected option: $1 - this should not happen."
           help ;;
      esac
    done

    if [[ ! -z ${ACTION_TYPE+x} ]]
    then
        actionCommand
    fi

    echo "run shell command: ${SHELL_COMMAND}"

    eval ${SHELL_COMMAND}
    exit 0
}

if [ $# -eq "0" ]
then
    help
fi

# 上个命令的退出状态
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
    help
fi

for command in $@
do
    case "$command" in
        "manage")
            shift;
            main $@; break ;;
        "-h"|"-help"|"--help"|"help")
            help $2; shift 2;break ;;
        *)
            echo "Unexpected command: $1 - this should not happen."
            help ;;
    esac
done
