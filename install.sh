#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

FILES=(
    ".bashrc"
    ".emacs"
    ".i3"
    ".i3status.conf"
)

BACKUP_DIR="$DIR/backup"

[ ! -r $BACKUP_DIR ] && mkdir $BACKUP_DIR

echo "Backing up original configuration files:"
for f in ${FILES[@]}; do
  src="$HOME/$f"
  if [ -r $src ]
  then
    if [ ! -h $src ]
    then
      printf "  - Moving %s to %s\n" $src $BACKUP_DIR
      mv $src $BACKUP_DIR
    else
      printf "  - Removing link %s\n" $src
      rm $src
    fi
  fi
done

echo "Linking new configuration files:"
for f in ${FILES[@]}; do
  src="$DIR/$f"
  link="$HOME/$f"
  printf "  - Linking $link to $src\n"
  ln -s $src $link
done

echo "Installing gnome-terminal solarized theme"
$DIR/submodule/gnome-terminal-colors-solarized/install.sh -s dark -p Default

echo "Installing dircolors solarized theme"
echo "eval \`dircolors $DIR/submodule/dircolors-solarized/dircolors.256dark\`" > "$HOME/.dircolors"
