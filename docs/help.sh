#!/bin/bash

#使用信息
main_usage="
The purpose of this program is to generate certbot-toy which is a docker images for managing Certbot certificates.

Unofficial build of EFF's Certbot with its plugin for doing DNS challenges using aliyun Cloud DNS.

usage:
    bash main.sh <command> [arguments]

The commands are:
    init    init third party dns plugins, include aliyun Cloud DNS.
    build   build docker images which is integrated EFF's Certbot with third party dns plugins.
    run     run docker images which is integrated EFF's Certbot with third party dns plugins.

Use \"bash main.sh help <command>\" for more information about a command.

OPTIONS
    [-h|--help]
        main usage of this program.
"

declare -a array_commands
array_commands=(init build run)

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