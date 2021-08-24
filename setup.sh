#!/usr/bin/env zsh

# Install Oh My Zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing Oh My Zsh, but keeping ~/.zshrc"
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --keep-zshrc
fi

if [[ ! -d ./pure ]]; then
  echo "Installing pure prompt"
  git clone https://github.com/sindresorhus/pure.git
fi

if [[ ! -d ./zsh_custom ]]; then
  mkdir -p ./zsh_custom
  echo "Installing zsh-nvm plugin..."
  git clone https://github.com/lukechilds/zsh-nvm ./zsh_custom/plugins/zsh-nvm
  echo "Installing zsh-syntax-highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./zsh_custom/plugins/zsh-syntax-highlighting
fi

if [[ ! -e ./Snazzy.terminal ]]; then
  echo "Downloading Snazzy Terminal theme..."
  curl https://raw.githubusercontent.com/sindresorhus/terminal-snazzy/main/Snazzy.terminal -o Snazzy.terminal -s
  echo "Done! Double click on Snazzy.terminal to install."
fi

if [[ -e ~/.zshrc ]]; then
  echo "Found ~/.zshrc! Not overriding. You will need to manually source the entrypoint."
  exit 1
fi

cat << EOF >> ~/.zshrc
# Load my dotfiles
source ~/dotfiles/.zsh_entrypoint
EOF