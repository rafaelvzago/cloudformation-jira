#!/bin/bash
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}')
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
STACK_NAME=$(aws ec2 describe-instances \
  --instance-id $INSTANCE_ID \
  --query 'Reservations[*].Instances[*].Tags[?Key==`aws:cloudformation:stack-name`].Value' \
  --region $REGION \
  --output text)

NODE1=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME --region $REGION --logical-resource-id "Node1" | grep 'PhysicalResourceId' | awk {'print $2'} | tr -d '"\|,')
NODE2=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME --region $REGION --logical-resource-id "Node2" | grep 'PhysicalResourceId' | awk {'print $2'} | tr -d '"\|,')
SERVICENODE=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME --region $REGION --logical-resource-id "ServiceNode" | grep 'PhysicalResourceId' | awk {'print $2'} | tr -d '"\|,')

NODE1IP=$(aws ec2 describe-instances --region $REGION --instance-id $NODE1 --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
NODE2IP=$(aws ec2 describe-instances --region $REGION --instance-id $NODE2 --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
SERVICENODEIP=$(aws ec2 describe-instances --region $REGION --instance-id $SERVICENODE --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)

sudo echo "$NODE1IP	Node1" >> /etc/hosts
sudo echo "$NODE2IP	Node2" >> /etc/hosts
sudo echo "$SERVICENODEIP	ServiceNode" >> /etc/hosts