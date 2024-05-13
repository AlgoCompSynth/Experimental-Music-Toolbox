#! /bin/bash

set -e

echo "Clearing Logs"
rm -f Logs/*
export LOGFILE=1command_line_setup.log

echo "Installing Linux zsh packages"
sudo apt-get update -qq
/usr/bin/time sudo apt-get upgrade -qqy \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  zsh \
  zsh-autosuggestions \
  zsh-doc \
  zsh-syntax-highlighting \
  zsh-theme-powerlevel9k \
  >> $LOGFILE 2>&1

echo "Cloning powerlevel10k"
rm -fr $HOME/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k

echo "Downloading patched MesloLG Nerd fonts"
mkdir --parents $HOME/.fonts
pushd $HOME/.fonts
wget -nc -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -nc -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -nc -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -nc -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
popd

echo "Setting configuration files"
cp bashrc $HOME/.bashrc
cp bash_aliases $HOME/.bash_aliases
cp vimrc $HOME/.vimrc
sudo cp vimrc /root/.vimrc
cp zshrc $HOME/.zshrc
cp p10k.zsh $HOME/.p10k.zsh

echo "Powerlevel10k is set up - type 'zsh' to enter the shell"
echo ""
echo "Finished"
