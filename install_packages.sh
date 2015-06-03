#!/bin/bash

PACKAGES_DESKTOP=(
  "feh"
  "gnome-terminal"
  "gnome-screensaver"
  "i3"
  "i3status"
  "i3-wm"
  "network-manager"
)

PACKAGES_APPLICATIONS=(
  "wireshark"
)

PACKAGES_NET=(
  "nmap"
  "whois"
)

PACKAGES_EDITOR=(
  "emacs24"
)

sudo apt-get install "${PACKAGES_DESKTOP[@]}"
sudo apt-get install "${PACKAGES_APPLICATIONS[@]}"
sudo apt-get install "${PACKAGES_NET[@]}"
sudo apt-get install "${PACKAGES_EDITOR[@]}"
