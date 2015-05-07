#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

FILES=(
    ".i3status.conf"
    ".i3"
    ".bashrc"
    ".emacs"
)

BACKUP_DIR="$DIR/backup"

mkdir $BACKUP_DIR

echo "Backing up original configuration files:"
for f in ${FILES[@]}; do
  src="$HOME/$f"
  printf "  - Moving %s to %s\n" $src $BACKUP_DIR
  mv $src $BACKUP_DIR
done

echo "Linking new configuration files:"
for f in ${FILES[@]}; do
  src="$DIR/$f"
  link="$HOME/$f"
  printf "  - Linking $link to $src\n"
  ln -s $src $link
done

    