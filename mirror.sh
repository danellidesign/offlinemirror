#!/bin/bash

# Change path to your disk
BASE_DEST="/media/path/to/device/ubuntu-mirror"

echo "Which release do you want to mirror?"
echo "1) jammy   (22.04 LTS)"
echo "2) noble   (24.04 LTS)"
echo "3) raccoon (26.04 LTS)"
echo "4) Other input..."
read -p "Please pick [1-4]: " auswahl

case $auswahl in
    1) RELEASE="jammy" ;;
    2) RELEASE="noble" ;;
    3) RELEASE="raccoon" ;;
    *) read -p "Enter codename manually: " RELEASE ;;
esac

DEST="$BASE_DEST/$RELEASE"
mkdir -p "$DEST"

echo "Staring iterative download from $RELEASE to $DEST..."

# debmirror automatically downloads missing packages
debmirror -a amd64 \
          --no-source \
          -s main,restricted,universe,multiverse \
          -h archive.ubuntu.com \
          -d $RELEASE,$RELEASE-updates,$RELEASE-security \
          -r /ubuntu \
          --progress \
          --method=http \
          --keyring=/usr/share/keyrings/ubuntu-archive-keyring.gpg \
          "$DEST"

echo "Mirroring of $RELEASE finished!"
