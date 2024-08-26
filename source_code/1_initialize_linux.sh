#! /usr/bin/env bash

set -e

if [ -x "/usr/bin/distrobox-export" ]
then
  # not on WSL - we need to unminimize
  echo "Running in a Distrobox container - restoring missing documentation"
  ./unminimize.sh
  echo ""
fi

echo "Cloning powerlevel10k"
rm -fr $HOME/powerlevel10k*
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k-media.git $HOME/powerlevel10k-media

echo "Downloading patched MesloLG Nerd fonts"
mkdir --parents $HOME/.fonts
pushd $HOME/.fonts
cp $HOME/powerlevel10k-media/*.ttf .
popd

echo "Setting configuration files"
cp zshrc $HOME/.zshrc
cp p10k.zsh $HOME/.p10k.zsh

echo ""
./upgrades.sh

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin

echo "Creating $HOME/Projects directory"
mkdir --parents $HOME/Projects

echo "Copying utility scripts to $HOME"
cp vimrc* edit-me-then-run-4-git-config.sh $HOME/

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Finished"
