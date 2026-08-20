#!/usr/bin/bash

# Configuration
SOURCE_DIR="/home/leo/Documents/Devops/Project/Leo/Varun"
BACKUP_DIR="/home/leo/Documents/Devops/Project/Leo/backups"
TIMESTAMP=$(date +"%d %h %y_%H %M %S")
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"

echo "----------------------------------------------------"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting automated backup..."
echo "----------------------------------------------------"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "[$(date '+%H:%M:%S')] Creating backup directory at $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "[$(date '+%H:%M:%S')] Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

echo "[$(date '+%H:%M:%S')] Archiving $SOURCE_DIR into $BACKUP_DIR/$ARCHIVE_NAME..."
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "[$(date '+%H:%M:%S')] ✔ Backup created successfully: $ARCHIVE_NAME"
    echo "[$(date '+%H:%M:%S')] Size: $(du -h "$BACKUP_DIR/$ARCHIVE_NAME" | awk '{print $1}')"
else
    echo "[$(date '+%H:%M:%S')] ✖ Backup failed."
    exit 1
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished backup run."
echo ""
