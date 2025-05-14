#!/bin/bash

echo "[Production] After install script started" >> /tmp/codedeploy.log

SECRET_LOCATION="trello-app/production"

# Fetch secrets from AWS Secrets Manager
SECRET_STRING=$(aws secretsmanager get-secret-value --secret-id $SECRET_LOCATION --query SecretString --output text)
echo $SECRET_STRING >> /tmp/codedeploy.log