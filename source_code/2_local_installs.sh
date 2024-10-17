#! /usr/bin/env bash

set -e

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin
echo 'export PATH="$PATH:$HOME/bin:$HOME/.local/bin"' >> $HOME/.bashrc
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

echo "Installing Meslo nerd fonts"
pushd /tmp

  echo "Downloading patched MesloLG Nerd fonts"
  rm --force --recursive Meslo*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
  unzip ../Meslo.zip

  echo "Copying to $HOME/.fonts"
  mkdir --parents $HOME/.fonts
  cp *.ttf $HOME/.fonts

  popd

# https://starship.rs/guide/#%F0%9F%9A%80-installation
echo "Installing Starship"
export BIN_DIR=$HOME/.local/bin
curl -sS https://starship.rs/install.sh | sh

echo "Initializing prompt configuration"
mkdir --parents $HOME/.config
starship preset nerd-font-symbols -o $HOME/.config/starship.toml

echo "Enabling Starship prompt for bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo ""
echo "Restart bash to get new Starship prompt"

echo "Finished"
