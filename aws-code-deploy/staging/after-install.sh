#!/bin/bash

SECRET_LOCATION="trello-app/staging"
REQUIRED_VARS=("TRELLO_API_KEY" "TRELLO_TOKEN" "TRELLO_BOARD_ID" "TRELLO_LIST_ID")


echo "[Staging] After install script started 123" >> /tmp/codedeploy.log

# Fetch secrets from AWS Secrets Manager
SECRET_STRING=$(aws secretsmanager get-secret-value --secret-id $SECRET_LOCATION --query SecretString --output text)
echo $SECRET_STRING >> /tmp/codedeploy.log

# Export secrets as environment variables
echo $SECRET_STRING | jq -r 'to_entries | .[] | "\(.key)=\(.value)"' >> /etc/sysconfig/trello-app-environments

# Load the environment variables
source /etc/sysconfig/trello-app-environments


# Extraer las claves del JSON
SECRET_KEYS=$(echo "$SECRET_STRING" | jq -r 'keys[]')

# Validar que todas las claves en REQUIRED_VARS existan en SECRET_KEYS
for VAR in "${REQUIRED_VARS[@]}"; do
    if ! echo "$SECRET_KEYS" | grep -q "^$VAR$"; then
        echo "ERROR: La clave '$VAR' no está en SECRET_STRING." >> /etc/sysconfig/trello-app-environments
        exit 1
    fi
done

echo "Todas las claves requeridas están presentes en SECRET_STRING." >> /etc/sysconfig/trello-app-environments



echo "Environment variables successfully set." >> /tmp/codedeploy.log

# Verify Java installation
echo "Verifying Java installation..." >> /tmp/codedeploy.log
if java -version 2>&1 | grep -q "openjdk version"; then
    echo "Java is already installed." >> /tmp/codedeploy.log
else
    echo "Installing Java..." >> /tmp/codedeploy.log
    yum install -y java-22-amazon-corretto
fi

echo "After-install steps completed." >> /tmp/codedeploy.log