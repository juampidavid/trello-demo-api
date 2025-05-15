#!/bin/bash

echo "[Staging] Before install script started" >> /tmp/codedeploy.log
echo "[Staging] Checking if service already exists" >> /tmp/codedeploy.log

bash create-service.sh