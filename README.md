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
    
## 3. Setting variables
Since this is small application. We can use a global variable holder in ```group_vars/all```
In there will be multiple ec2 host and you want do have separate variables inventory for all host.
You can create and file name exactly as the name of your host and puts the variables in it.
Please check [Ansible Best practice for more detail on using group_vars](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)

    
## 4. Deploying EC2
Change the variables in `roles/deploy/vars/main.yml` as per your requirements. During the deployment
```temporary_deployment_key``` is created under __keys__ folder. In case something goes wrong wile ec2 instance creation 
this key can be used for login to the system.

    bin/deploy_ec2.sh <AWS profile>
    
    Eg: bin/deploy_ec2.sh dev

## 5. Deploying your ssh key
Put all the list of public shh keys user under ````roles/update-ssh-authorized-list/files```` that should go in 
```/home/ec2-user/.ssh/authorized_keys```. Then the user can access the machine with ssh using their private key. 
At this point temporary key will be removed and the private key will be of no use.
    
    bin/update_ssh_on_ec2.sh <AWS profile> <EC2 machine names>
    
__You can give the name of all the machines you want the keys to be deployed to as__ ````bin/update_ssh_on_ec2.sh dev local_server prod_server````    


## 5. Login to ec2
You can test if you keys working or not by logging to the ec2 instances.

    bin/login_to_ec2.sh <AWS profile> <EC2 machine name>
    
__Example__ ``bin/login_to_ec2.sh dev local_server``
