#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

FILES_HOMEDIR=(
  ".bash_aliases"
  ".bashrc"
  ".emacs"
  ".gitconfig"
  ".i3"
)

FILES_SRC[0]="submodule/rainbow-delimiters/rainbow-delimiters.el"
FILES_DST[0]="$HOME/.emacs.d/rainbow-delimiters.el"
FILES_SRC[1]="submodule/Fill-Column-Indicator/fill-column-indicator.el"
FILES_DST[1]="$HOME/.emacs.d/fill-column-indicator.el"

BACKUP_DIR="$DIR/backup"

function backup_file() {
  local src=$1
  if [ -h $src ]
  then
    printf "  - Removing link %s\n" $src
    rm $src
  elif [ -e $src ]
  then
    printf "  - Moving %s to %s\n" $src $BACKUP_DIR
    mv $src $BACKUP_DIR
  fi
}

function link_file {
  local src=$1
  local link=$2
  printf "  - Linking $link to $src\n"
  ln -s $src $link
}

[ ! -r $BACKUP_DIR ] && mkdir $BACKUP_DIR

echo "Installing configuration files:"
for f in ${FILES_HOMEDIR[@]}; do
  backup_file "$HOME/$f"
  link_file "$DIR/$f" "$HOME/$f"
done
for (( i=0; i<${#FILES_SRC[@]}; i++ )); do
  src="${DIR}/${FILES_SRC[$i]}"
  dst="${FILES_DST[$i]}"
  backup_file "$dst"
  link_file "$src" "$dst"
done

echo "Installing gnome-terminal solarized theme"
$DIR/submodule/gnome-terminal-colors-solarized/install.sh -s dark -p Default

echo "Installing dircolors solarized theme"
echo "eval \`dircolors $DIR/submodule/dircolors-solarized/dircolors.256dark\`" > "$HOME/.dircolors"
