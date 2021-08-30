#!/bin/bash

source ./docs/help.sh
source ./docs/error.sh

if [ $# -eq "0" ]
then
    error "requireCommand"
fi

# 上个命令的退出状态
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
    help
fi

for command in $@
do
    case "$command" in
        "init")
            bash ./scripts/dns-plugins/alidns.sh; break ;;
        "build")
            bash ./scripts/docker/build-images.sh; break ;;
        "run")
            bash ./scripts/docker/run-images.sh; break ;;
        "-h"|"-help"|"--help"|"help")
            help $2; shift 2;break ;;
        *)
            echo "Unexpected command: $1 - this should not happen."
            help ;;
    esac
done