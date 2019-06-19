#! /bin/sh

if (( $# < 2 )); then
    echo "Please use bin/update_ssh_on_ec2.sh <AWS profile> <EC2 machine names>"
    exit 1
else
    profile=$1

    # This is suppose to be the list of all the machines you want your ssh keys to be added to authorized list.
    for ec2_machine_name in $*
    do
        AWS_PROFILE=${profile} ansible-playbook security_playbook.yml --extra-vars "ec2_machine_name=${ec2_machine_name}"
    done
fi
