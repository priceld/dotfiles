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
  # Install Snazzy theme and make default
  # Based on: https://github.com/kentcdodds/dotfiles/blob/master/.macos
  osascript <<EOD
tell application "Terminal"
  local allOpenedWindows
  local initialOpenedWindows
  local windowID
  set themeName to "Snazzy"
  (* Store the IDs of all the open terminal windows. *)
  set initialOpenedWindows to id of every window
  (* Open the custom theme so that it gets added to the list
      of available terminal themes (note: this will open two
      additional terminal windows). *)
  do shell script "open '$HOME/dotfiles/" & themeName & ".terminal'"
  (* Wait a little bit to ensure that the custom theme is added. *)
  delay 1
  (* Set the custom theme as the default terminal theme. *)
  set default settings to settings set themeName
  (* Get the IDs of all the currently opened terminal windows. *)
  set allOpenedWindows to id of every window
  repeat with windowID in allOpenedWindows
    (* Close the additional windows that were opened in order
        to add the custom theme to the list of terminal themes. *)
    if initialOpenedWindows does not contain windowID then
      close (every window whose id is windowID)
    (* Change the theme for the initial opened terminal windows
        to remove the need to close them in order for the custom
        theme to be applied. *)
    else
      set current settings of tabs of (every window whose id is windowID) to settings set themeName
    end if
  end repeat
end tell
EOD
  echo "Done!"
fi

if [[ -e ~/.zshrc ]]; then
  echo "Found ~/.zshrc! Not overriding. You will need to manually source the entrypoint."
  exit 1
fi

cat << EOF >> ~/.zshrc
# Load my dotfiles
source ~/dotfiles/.zsh_entrypoint
EOF