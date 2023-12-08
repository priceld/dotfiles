#!/usr/bin/env zsh

if [[ ! -d ~/work/.fzf ]]; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/work/.fzf
  ~/work/.fzf/install
fi

if [[ ! -f "${0:a:h}/.config/alacritty/catppuccin" ]]; then
  echo "Cloning catppuccin theme for alacritty..."
  git clone https://github.com/catppuccin/alacritty.git "${0:a:h}/.config/alacritty/catppuccin"
fi

echo "Invoking stow to setup dotfiles..."
stow --dir="${0:a:h}" --target=$HOME .
