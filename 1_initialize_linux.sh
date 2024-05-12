#! /usr/bin/env bash

set -e

./upgrades.sh

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin

echo "Creating $HOME/Projects directory"
mkdir --parents $HOME/Projects

echo "Copying utility scripts to $HOME"
cp vimrc* edit-me-then-run-4-git-config.sh start_jupyter_lab_*.sh $HOME/

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Finished"
