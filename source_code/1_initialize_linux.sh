#! /usr/bin/env bash

set -e

export KERNEL_RELEASE=`uname --kernel-release`
echo ""
echo "KERNEL_RELEASE: $KERNEL_RELEASE"

if [[ ! "$KERNEL_RELEASE" =~ "WSL2" ]]
then
  # not on WSL - we need to unminimize
  echo "Restoring missing documentation"
  ./unminimize.sh
  echo ""
fi

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
