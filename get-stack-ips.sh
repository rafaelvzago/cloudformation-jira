#!/bin/bash
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}')
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
STACK_NAME=$(aws ec2 describe-instances \
  --instance-id $INSTANCE_ID \
  --query 'Reservations[*].Instances[*].Tags[?Key==`aws:cloudformation:stack-name`].Value' \
  --region $REGION \
  --output text)

NODE1=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --region $REGION --query "Stacks[0].Outputs[?OutputKey=='Node1PrivIp'].OutputValue" --output text)
NODE2=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --region $REGION --query "Stacks[0].Outputs[?OutputKey=='Node2PrivIp'].OutputValue" --output text)
SERVICENODE=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --region $REGION --query "Stacks[0].Outputs[?OutputKey=='ServiceNodePrivIp'].OutputValue" --output text)

sudo echo "$NODE1	Node1" >> /etc/hosts
sudo echo "$NODE2	Node2" >> /etc/hosts
sudo echo "$SERVICENODE	ServiceNode" >> /etc/hosts