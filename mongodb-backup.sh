#!/bin/bash

DB_NAME="tickets"
DOCKER_CONTAINER_NAME="wonderful_shockley"
# Backup settings
BACKUP_DIR="/home/wittyticketing/backup/"
DATE=`date "+%F %H:%M:%S"`
DOCKER_DIR="/data/db/backup"
BACKUP_FILE="$DB_NAME-$DATE"
mount_path="/home/wittyticketing/windows-mount-db/"
docker exec -i $DOCKER_CONTAINER_NAME mongodump --db $DB_NAME --out "$DOCKER_DIR"/"$BACKUP_FILE"

# Copy the backup files from the Docker container to the host machine
docker cp $DOCKER_CONTAINER_NAME:"$DOCKER_DIR"/"$BACKUP_FILE" "$BACKUP_DIR"

# Remove the backup files from the Docker container
docker exec -i $DOCKER_CONTAINER_NAME rm -r "$DOCKER_DIR"/"$BACKUP_FILE"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed"
fi

cp -r "$BACKUP_DIR"/* $mount_path

if [ $? == 0 ]
    then
     rm -rf "$BACKUP_DIR"*
     find $mount_path -type f -mtime +10 -exec rm {} \;
     exit 1
    else
     echo "----------------------------------------------------"
     echo -e "\033[0;31m \n!!!!! Backup Failure !!!!! "
fi
