#!/bin/bash

source ${APP_DIR}docs/error.sh

if [[ -z ${ACCESS_KEY_ID+x} || -z ${ACCESS_KEY_SECRET+x} || -z ${ENDPOINT+x} ]]
    then
    error "requireDnsParams"
fi

if [ -z $DNS_PLUGIN ]; then
    error "requireDnsPlugin"
fi

# 调用DNS插件
function callDnsPlugin(){
    if [ -f /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID ]; then
        RECORD_ID=$(cat /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID)
        rm -f /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID
    else
        error "requireDnsRecordId"
    fi

    RES=$(${APP_DIR}bin/${DNS_PLUGIN}-dns -action delete -endpoint $ENDPOINT -accessKeyId $ACCESS_KEY_ID -accessKeySecret $ACCESS_KEY_SECRET -recordId $RECORD_ID)
    STATUS=$(echo $RES | cut -d ":" -f 1)

    if [ $STATUS = "ok" ]; then
        echo $STATUS
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
