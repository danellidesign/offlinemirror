#!/bin/bash

# Path to device
HDD_PATH="/media/path/to/device/ubuntu-mirror/"
# Targetpath on server
WEB_PATH="/var/www/html/ubuntu-repo/"

# check if device is mounted
if [ ! -d "$HDD_PATH" ]; then
    echo "Error: Device not found in $HDD_PATH !"
    exit 1
fi

mkdir -p "$WEB_PATH"

echo "Copying changes from disk to server..."

# rsync Optionen:
# -a (Archiv, behält Berechtigungen)
# -v (Verbose, zeigt an was passiert)
# -h (Human readable, Lesbare Dateigrößen)
# --delete (Löscht Pakete auf dem Server, die im offiziellen Repo nicht mehr existieren)
rsync -avh --delete "$HDD_PATH" "$WEB_PATH"

echo "Finished sync."
