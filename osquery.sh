#!/bin/bash
# define hostname in the /etc/default/osqueryd file
hostname=$(ip addr | grep 'eth0' | grep 'inet' | awk '{print $2}' | awk -F/ '{print $1}')
sudo echo "OSQUERY_DEPLOYMENT_ID=$hostname" >> /etc/default/osqueryd

# define region in the /etc/osquery/osquery.flags file
region=$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
sudo echo "--aws_region=$region" >> /etc/osquery/osquery.flags
sudo echo "--aws_sts_region=$region" >> /etc/osquery/osquery.flags

sudo service osqueryd restart