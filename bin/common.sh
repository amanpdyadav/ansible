#! /bin/sh

function resolve_host {
    profile=$1
    hostname=$2
    ./ec2.py --profile ${profile} --host ${hostname} |grep ec2_public_dns_name |cut -d \" -f 4
}

function ssh_login {
    profile=$1
    hostname=$2
    shift 2

    real_name=`resolve_host ${profile} ${hostname}`

    echo "Real name: ${real_name}"
    if [ -z "$real_name" ] ; then
        echo "do not know about ${hostname}"
        exit 1
    else
        # First try with temporary key created during instance created.
        if ssh -i keys/temporary_deployment_key ec2-user@$real_name; then
            echo "Success"
        else
            echo "Trying with default public key"
            ssh ec2-user@$real_name
        fi
    fi
}
