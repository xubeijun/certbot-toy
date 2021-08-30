#!/bin/bash

source ${APP_DIR}docs/error.sh

if [[ -z ${ACCESS_KEY_ID+x} || -z ${ACCESS_KEY_SECRET+x} || -z ${ENDPOINT+x} ]]
    then
    error "requireDnsParams"
fi

# 调用DNS插件
function callDnsPlugin(){
    if [ -f /tmp/DNS_RECORD_ID_$CERTBOT_DOMAIN ]; then
        RECORD_ID=$(cat /tmp/DNS_RECORD_ID_$CERTBOT_DOMAIN)
    else
        error "requireDnsRecordId"
    fi

    if [ -f /tmp/DNS_PLUGIN ]; then
        DNS_PLUGIN=$(cat /tmp/DNS_PLUGIN)
    else
        error "requireDnsPlugin"
    fi

    RES=$(${APP_DIR}bin/${DNS_PLUGIN}-dns -action delete -endpoint $ENDPOINT -accessKeyId $ACCESS_KEY_ID -accessKeySecret $ACCESS_KEY_SECRET -recordId $RECORD_ID)
    STATUS=$(echo $RES | cut -d ":" -f 1)

    if [ $STATUS = "ok" ]; then
        rm -f /tmp/DNS_RECORD_ID_$CERTBOT_DOMAIN
        rm -f /tmp/DNS_PLUGIN
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
