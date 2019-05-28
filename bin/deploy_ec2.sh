#! /bin/sh

function deploy {
    profile=$1
    shift 1
    other_vars=$@

    echo "****************************************************************************************"
    echo "Deployment started"
    echo "****************************************************************************************"

    AWS_PROFILE=${profile} ansible-playbook infra_playbook.yml --extra-vars "profile=${profile}" "$@"
    if [ $? -ne 0 ]; then
      echo "****************************************************************************************"
      echo "Stopping deployment script as something failed."
      echo "****************************************************************************************"
      exit 1
    fi

    ./ec2.py --profile ${profile} --refresh >/dev/null

    echo "****************************************************************************************"
    echo "The deployment is success."
    echo "****************************************************************************************"
}

if [ -z $1 ]
then

  echo "Please updated the following files as show in the example below. "
  echo " ---------------- | ---------------------------------------"
  echo "| ~/.aws/config   | ~/.aws/credentials                     |"
  echo " ---------------- | --------------------------------------- "
  echo " [default]        | [default]                               "
  echo " region=eu-west-1 | aws_access_key_id=<GET IT FROM AWS>     "
  echo " output=json      | aws_secret_access_key=GET IT FROM AWS>  "
  echo " -----------------|-----------------------------------------"
  echo " [profile prod]   | [profile prod]                          "
  echo " region=eu-west-1 | aws_access_key_id=<GET IT FROM AWS>     "
  echo " output=json      | aws_secret_access_key=GET IT FROM AWS>  "
  echo " -----------------|-----------------------------------------"

  echo Enter aws profile?
  read profile
  deploy $profile
else
   deploy $@
fi


