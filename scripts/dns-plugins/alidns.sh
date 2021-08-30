#!/bin/bash

source ./scripts/dns-plugins/init-config.sh

export GOOS=${MACHINE_GOOS}
export GOARCH=${MACHINE_GOARCH}

echo "initial third party dns plugins ..."

go get github.com/alibabacloud-go/alidns-20150109/client &&
go get github.com/alibabacloud-go/darabonba-openapi/client &&
go get github.com/alibabacloud-go/tea/tea &&

echo "begin building aliyun dns plugins ..."

go build -o ./scripts/docker/bin/aliyun-dns ./scripts/dns-plugins/alidns.go

echo "Complete initialization."