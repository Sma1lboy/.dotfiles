#!/bin/bash

echo "Starting Nvim folder backup..."
CONFIG=$HOME/.config
TARGET_DEST=$HOME/.config/nvim
BACKUP_DIR=$HOME/.config/nvim_backups

if ! [[ -d $CONFIG ]]; then
  echo "The config folder is not exist"
  exit 1
fi

if ! [[ -d $TARGET_DEST ]]; then
  echo "The Nvim folder is not exist"
  exit 1
fi

if ! [[ -d $BACKUP_DIR ]]; then
  echo "Detected First time backup"
  echo "Creating backups folder at path $BACKUP_DIR"
  mkdir $BACKUP_DIR
fi

DATE=$(date "+%d-%m-%H-%M-%S")
OUTPUT="$BACKUP_DIR/nvim-backups-$DATE.tar.gz"
cd $CONFIG && tar czf $OUTPUT ./nvim
echo "Backup successful at location $OUTPUT"


