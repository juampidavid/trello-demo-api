#!/bin/bash

echo "[Staging] Validate service script started" >> /tmp/codedeploy.log

# Validate trello-api service
if systemctl is-active --quiet trello-api.service; then
    echo "trello-api.service is running." >> /tmp/codedeploy.log
else
    echo "trello-api.service is not running." >> /tmp/codedeploy.log
    exit 1
fi

echo "Validation completed successfully." >> /tmp/codedeploy.log