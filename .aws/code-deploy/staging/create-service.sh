#!/bin/bash

echo "[Staging] Generating Service file" >> /tmp/codedeploy.log

FILE_PATH="/etc/systemd/system/trello-api.service"

if [ ! -f "$FILE_PATH" ]; then
    echo "[Staging] Generating file... $FILE_PATH" >> /tmp/codedeploy.log
    cat <<EOL > "$FILE_PATH"
[Unit]
Description=Trello Api

[Service]
EnvironmentFile=/etc/sysconfig/trello-app-environments
ExecStart=/usr/bin/java -jar --enable-preview /home/ec2-user/trello-api/api.jar
SuccessExitStatus=143
StandardOutput=append:/var/log/trello-api/stdout.log
StandardError=append:/var/log/trello-api/stderr.log

[Install]
WantedBy=multi-user.target
EOL
    echo "[Staging] File created successfully." >> /tmp/codedeploy.log
else
    echo "[Staging] File already exists. Skipping creation." >> /tmp/codedeploy.log
fi