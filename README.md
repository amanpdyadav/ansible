# ANSIBLE
This repository has Ansible role based scripts for deploying ec2 instances on AWS.

# Requirements
- boto
- boto3
- botocore
- python >= 2.6
- [Aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## 1. Quick Start
The scripts should be run from ansible directory.

## 2. Initial preparation

The **~/.aws/credentials** should look something like the following.

    [default]
    aws_access_key_id = ***********
    aws_secret_access_key = *******
    
    [dev]
    aws_access_key_id = ***********
    aws_secret_access_key = *******
    
    [prod]
    aws_access_key_id = ***********
    aws_secret_access_key = *******

Create also a config file to specify some default values for the different environments.
The **~/.aws/config** should look something like this:

    [default]
    region=eu-west-1
    output=json
    
    [profile loadtest]
    region=eu-central-1
    output=json
    
    [profile dev]
    region=eu-west-1
    output=json
    
    [profile prod]
    region=ap-southeast-1
    output=json
    
## 3. Deploying EC2
Change the variables in `roles/deploy/vars/main.yml` as per your requirements.

    bin/deploy_ec2.sh <AWS profile>
    
    Eg: bin/deploy_ec2.sh dev
