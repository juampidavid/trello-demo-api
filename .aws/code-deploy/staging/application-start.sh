#!/bin/bash

echo "[Staging] Application start script started" >> /tmp/codedeploy.log

# Load the environment variables
echo "[Staging] Loading environment variables..." >> /tmp/codedeploy.log
source /etc/sysconfig/reup-api

# Start the trello-api service
echo "[Staging] Starting reup-api.service..." >> /tmp/codedeploy.log
systemctl start trello-api.service

# Verify trello-api service status
if systemctl is-active --quiet trello-api.service; then
    echo "trello-api.service started successfully." >> /tmp/codedeploy.log
else
    echo "Failed to start trello-api.service." >> /tmp/codedeploy.log
    exit 1
fi

# Wait for Spring application to initialize
echo "Waiting for Spring application to initialize..." >> /tmp/codedeploy.log
timeout=300  # Timeout in seconds
interval=5   # Interval between checks in seconds
elapsed=0

while [ $elapsed -lt $timeout ]; do
    if grep -q "Started ApiApplication" /var/log/trello-api/stdout.log; then
        echo "Spring application has initialized successfully." >> /tmp/codedeploy.log
        break
    fi
    sleep $interval
    elapsed=$((elapsed + interval))
done

echo "Application started successfully." >> /tmp/codedeploy.log