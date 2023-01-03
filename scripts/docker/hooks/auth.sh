#!/bin/bash

source ${APP_DIR}docs/error.sh

if [[ -z ${ACCESS_KEY_ID+x} || -z ${ACCESS_KEY_SECRET+x} || -z ${ENDPOINT+x} ]]
    then
    error "requireDnsParams"
fi

if [ -z $DNS_PLUGIN ]; then
    error "requireDnsPlugin"
fi

DOMAIN=$(echo $CERTBOT_DOMAIN | grep -E '[a-zA-Z0-9-]+\.[a-zA-Z0-9]+$' -o)

RR="_acme-challenge"

# 调用DNS插件
function callDnsPlugin(){
    RES=$(${APP_DIR}bin/${DNS_PLUGIN}-dns -action create -endpoint $ENDPOINT -accessKeyId $ACCESS_KEY_ID -accessKeySecret $ACCESS_KEY_SECRET -domainName $DOMAIN -rr $RR -value $CERTBOT_VALIDATION)
    STATUS=$(echo $RES | cut -d ":" -f 1)

    if [ ! -d /tmp/CERTBOT_$CERTBOT_DOMAIN ];then
        mkdir -m 0777 /tmp/CERTBOT_$CERTBOT_DOMAIN
    fi

    if [ $STATUS = "ok" ]; then
        RECORD_ID=$(echo $RES | cut -d ":" -f 2)
        echo $RECORD_ID > /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID
        sleep ${REFRESH_SLEEP:="60"}
    else
        echo $RES
    fi
}

case "$DNS_PLUGIN" in
    "aliyun")
        callDnsPlugin $@
        ;;
    *)
        echo "Unexpected param: $DNS_PLUGIN - this should not define."
        help ;;
esac
