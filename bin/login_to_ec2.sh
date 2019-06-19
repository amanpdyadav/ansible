#!/bin/bash

source bin/common.sh

if (( $# < 2 )); then
    echo "Please use bin/login_to_ec2.sh <AWS profile> <EC2 machine name>"
    exit 1
else
    ssh_login $1 $2
fi

