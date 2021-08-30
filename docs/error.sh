#!/bin/bash

declare -A error

error["requireCommand"]='Require command params!'

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