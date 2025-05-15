#!/bin/bash

echo "[Staging] Application start script started" >> /tmp/codedeploy.log

# Load the environment variables
echo "[Staging] Loading environment variables..." >> /tmp/codedeploy.log
source /etc/sysconfig/trello-app-environments

sudo mkdir /var/log/trello-api >> /tmp/codedeploy.log

sudo touch /var/log/trello-api/stdout.log >> /tmp/codedeploy.log
sudo touch /var/log/trello-api/stderr.log >> /tmp/codedeploy.log

# Start the trello-api service
echo "[Staging] Starting trello-api.service..." >> /tmp/codedeploy.log
systemctl daemon-reload
systemctl start trello-api.service
systemctl enable trello-api.service

if service trello-api status | grep -q running; then
    echo "API is running." >> /tmp/codedeploy.log
else
    echo "Failed to start API." >> /tmp/codedeploy.log
fi

echo "[Staging] Starting trello-api.service..." >> /tmp/codedeploy.log

# Verify trello-api service status
if systemctl is-active --quiet trello-api.service; then
    echo "[Staging] trello-api.service started successfully." >> /tmp/codedeploy.log
else
    echo "[Staging] Failed to start trello-api.service." >> /tmp/codedeploy.log
    exit 1
fi



# Wait for Spring application to initialize
echo "Waiting for Spring application to initialize..." >> /tmp/codedeploy.log
timeout=300  # Timeout in seconds
interval=5   # Interval between checks in seconds
elapsed=0

while [ $elapsed -lt $timeout ]; do
    if grep -q "Started Application" /var/log/trello-api/stdout.log; then
        echo "Spring application has initialized successfully." >> /tmp/codedeploy.log
        break
    fi
    sleep $interval
    elapsed=$((elapsed + interval))
done

echo "Application started successfully." >> /tmp/codedeploy.log