#!/bin/dash

favourite() {
    local name command
    name=$1
    command=$2
    echo "My name is $name, my favourite command is $command" 
}

favourite Andrew rm
favourite Rosemary jq
favourite Dylan rsync
