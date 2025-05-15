#!/bin/bash

# Ruta donde se creará el archivo
FILE_PATH="/home/ec2-user/create-service.sh"

# Verificar si el archivo ya existe
if [ ! -f "$FILE_PATH" ]; then
    echo "Creando archivo $FILE_PATH..."
    cat <<EOL > "$FILE_PATH"
[Unit]
Description=ReUp Api

[Service]
EnvironmentFile=/etc/sysconfig/reup-api
ExecStart=/usr/bin/java -jar --enable-preview /home/ec2-user/reup-api/api.jar
SuccessExitStatus=143
StandardOutput=append:/var/log/reup-api/stdout.log
StandardError=append:/var/log/reup-api/stderr.log
c
[Install]
WantedBy=multi-user.target
EOL
    echo "Archivo creado exitosamente."
else
    echo "El archivo ya existe, no se ha modificado."
fi