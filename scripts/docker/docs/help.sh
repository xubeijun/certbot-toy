#!/bin/bash

#使用信息
main_usage="
certbot-toy is a docker images for managing Certbot certificates.

Unofficial build of EFF's Certbot with its plugin for doing DNS challenges using aliyun Cloud DNS.

usage:
    certbot-toy <command> [arguments]

The commands are:
    manage  manage certbot certificates, these are common certbot-toy commands used in various situations

Use \"certbot-toy help <command>\" for more information about a command.

OPTIONS
    [-h|--help]
        certbot-toy's main usage.
"

declare -a array_commands
array_commands=(manage)

# 显示帮助信息
function help(){
    if [ $# -eq "0" ]
        then
        echo "${main_usage}"
    elif [[ "${array_commands[@]}" =~ "$1" ]]
        then
        helpCommand $1
    else
        echo "${main_usage}"
    fi
    exit 0
}

# 返回命令帮助详情
function helpCommand(){
    cat ./docs/help/$1.txt
}