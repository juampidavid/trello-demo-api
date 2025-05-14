#!/bin/bash

echo "[Staging] After install script started 123" >> /tmp/codedeploy.log

SECRET_LOCATION="trello-app/staging"

# Fetch secrets from AWS Secrets Manager
SECRET_STRING=$(aws secretsmanager get-secret-value --secret-id $SECRET_LOCATION --query SecretString --output text)
echo $SECRET_STRING >> /tmp/codedeploy.log