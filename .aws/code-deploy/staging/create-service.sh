#!/bin/bash

FILE_PATH="/etc/systemd/system/trello-api.service"

if [ ! -f "$FILE_PATH" ]; then
    echo "Generating file... $FILE_PATH"
    cat <<EOL > "$FILE_PATH"
[Unit]
Description=Trello Api

[Service]
EnvironmentFile=/etc/sysconfig/trello-api
ExecStart=/usr/bin/java -jar --enable-preview /home/ec2-user/trello-app-api/api.jar
SuccessExitStatus=143
StandardOutput=append:/var/log/trello-api/stdout.log
StandardError=append:/var/log/trello-api/stderr.log
c
[Install]
WantedBy=multi-user.target
EOL
    echo "File created successfully."
else
    echo "File already exists. Skipping creation."
fi