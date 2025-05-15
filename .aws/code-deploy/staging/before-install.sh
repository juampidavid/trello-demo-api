#!/bin/bash

echo "[Staging] Before install script started" >> /tmp/codedeploy.log

# Create necessary directories
echo "[Staging] Creating necessary directories..."
mkdir -p /home/ec2-user/trello-api && echo "[Staging] Main folder successfully created" >> /tmp/codedeploy.log
mkdir -p /home/ec2-user/tmp && echo "[Staging] Temp folder successfully created" >> /tmp/codedeploy.log