#!/usr/bin/env zsh

# This script should take the path to a binary as the first argument.
alacritty_binary=$1

if [[ ! -x $alacritty_binary ]]; then
  echo "Usage: $0 <path/to/alacritty>"
  exit 1
fi

# Derive the bundle version from the binary itself, so the plist can never
# drift from what is actually shipped. `alacritty --version` prints
# "alacritty <version>".
version=$("$alacritty_binary" --version | awk 'NR == 1 { print $2 }')

if [[ -z $version ]]; then
  echo "Could not determine the version of $alacritty_binary"
  exit 1
fi

# Create the .app directory
mkdir Alacritty.app

cp -r ./stuff-for-app-package/* Alacritty.app/

# `Contents/MacOS` is empty in the template, so git does not track it.
mkdir -p Alacritty.app/Contents/MacOS

cp "$alacritty_binary" Alacritty.app/Contents/MacOS/

plutil -replace CFBundleShortVersionString -string "$version" \
  Alacritty.app/Contents/Info.plist
