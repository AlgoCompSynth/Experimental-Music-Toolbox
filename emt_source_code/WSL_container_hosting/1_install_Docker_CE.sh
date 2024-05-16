#! /usr/bin/env bash

set -e

if ! [[ `uname --kernel-release` =~ "WSL2" ]]
then
  echo "WSL2 not detected"
  echo "..exit -1024: container hosting is only supported on WSL2"
  exit -1024
fi

echo "Clearing 'Logs'"
rm -f Logs/*
export LOGFILE=$PWD/Logs/1_install_Docker_CE.log

echo "..adding Docker GPG key and repository"
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
sudo apt-get install -qqy --no-install-recommends ca-certificates curl \
  >> $LOGFILE 2>&1
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package cache"
sudo apt-get update -qq \
  >> $LOGFILE 2>&1

echo "Installing Docker"
sudo apt-get install -qqy --no-install-recommends \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin \
  >> $LOGFILE 2>&1

echo "Enabling docker for $USER"
sudo usermod -aG docker $USER

echo "Finished"
