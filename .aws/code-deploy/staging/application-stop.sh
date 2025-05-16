#!/bin/bash

echo "[Staging] Application stop script started" >> /tmp/codedeploy.log


# Stop the  service
if systemctl is-active --quiet trello-api.service; then
    echo "Stopping reup-api.service..." >> /tmp/codedeploy.log
    systemctl stop trello-api.service
else
    echo "reup-api.service is not running."
fi

# Stop the Tomcat service
if systemctl is-active --quiet tomcat; then
    echo "Stopping Tomcat service..."
    systemctl stop tomcat
else
    echo "Tomcat service is not running."
fi

# Ensure services are stopped
echo "Checking the status of the services..."

if systemctl is-active --quiet reup-api.service; then
    echo "Failed to stop reup-api.service."
else
    echo "Successfully stopped reup-api.service."
fi

if systemctl is-active --quiet tomcat; then
    echo "Failed to stop Tomcat service."
else
    echo "Successfully stopped Tomcat service."
fi