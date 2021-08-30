#!/bin/bash

declare -A error

error["requireCommand"]='Require command params!'
error["requireOption"]='Require options params!'
error["invalidAction"]='Invalid action!'
error["invalidDomain"]='Invalid domain! Please edit variable `valid_domain` in file which name as certs-config.sh'
error["invalidParams"]='Invalid params!'
error["invalidDns"]='Invalid dns!'
error["requireDnsParams"]='Require config dns params! Such as ACCESS_KEY_ID,ACCESS_KEY_SECRET,ENDPOINT. The config params is in the ./certbot-toy/scripts/docker/config/user.env file.'
error["requireDnsRecordId"]='Require dns RECORD_ID which is recode in /tmp/DNS_RECORD_ID_$CERTBOT_DOMAIN file.'
error["requireDnsPlugin"]='Require dns DNS_PLUGIN which is recode in /tmp/DNS_PLUGIN file.'


# 显示错误信息
function error(){
    if [ $# -eq "0" ]
        then
        echo ${error["requireCommand"]}
    elif [[ ${error[$1]} ]]
        then
        echo ${error[$1]}
    else
        echo ${error["invalidParams"]}
    fi
    exit 1
}