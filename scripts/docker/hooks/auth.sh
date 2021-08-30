#!/bin/bash

source ${APP_DIR}docs/error.sh

error "requireDnsParams"

if [[ -z ${ACCESS_KEY_ID+x} || -z ${ACCESS_KEY_SECRET+x} || -z ${ENDPOINT+x} ]]
    then
    error "requireDnsParams"
fi

if [ -f /tmp/DNS_PLUGIN ]; then
    DNS_PLUGIN=$(cat /tmp/DNS_PLUGIN)
else
    error "requireDnsPlugin"
fi

RR="_acme-challenge"

# 调用DNS插件
function callDnsPlugin(){
    RES=$(${APP_DIR}bin/${DNS_PLUGIN}-dns -action create -endpoint $ENDPOINT -accessKeyId $ACCESS_KEY_ID -accessKeySecret $ACCESS_KEY_SECRET -domainName $DOMAIN -rr $RR -value $CERTBOT_VALIDATION)
    STATUS=$(echo $RES | cut -d ":" -f 1)

    if [ $STATUS = "ok" ]; then
        RECORD_ID=$(echo $RES | cut -d ":" -f 2)
        echo $RECORD_ID > /tmp/DNS_RECORD_ID_$CERTBOT_DOMAIN
        sleep ${REFRESH_SLEEP:="25"}
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
