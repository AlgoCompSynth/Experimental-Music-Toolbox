#! /usr/bin/env bash

set -e

export LOGFILE=$PWD/Logs/3_install_NVIDIA_Container_Toolkit.log

echo "Getting COMPUTE_MODE"
source ../set_compute_mode.sh
echo "COMPUTE_MODE: $COMPUTE_MODE"
if [ "$COMPUTE_MODE" != "CUDA" ]
then
  echo "..exit -1024: 'CUDA' COMPUTE_MODE is require to run NVIDIA software"
  exit -1024
fi

DISTRIBUTOR=`lsb_release -is | grep -v "No LSB modules"`
CODENAME=`lsb_release -cs | grep -v "No LSB modules"`

echo "DISTRIBUTOR: $DISTRIBUTOR"
echo "CODENAME: $CODENAME"
if [ "$CODENAME" != "jammy" ]
then

  echo "..exit -1024 Only Ubuntu 'jammy' is currently supported"
  exit -1024

fi

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-apt
echo "Installing keyring and repository"
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
  sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

echo "Updating package cache"
sudo apt-get update -qq

echo "Installing NVIDIA Container Toolkit"
/usr/bin/time sudo apt-get install -qqy nvidia-container-toolkit \
  >> $LOGFILE 2>&1

echo "Finished"
