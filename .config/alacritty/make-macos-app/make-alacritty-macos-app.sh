#!/usr/bin/env zsh

# This script should take the path to a binary as the first argument.
alacritty_binary=$1

if [[ ! -x $alacritty_binary ]]; then
  echo "Usage: $0 <path/to/alacritty>"
  exit 1
fi

# Create the .app directory
mkdir Alacritty.app

cp -r ./stuff-for-app-package/* Alacritty.app/

cp $alacritty_binary Alacritty.app/Contents/MacOS/

