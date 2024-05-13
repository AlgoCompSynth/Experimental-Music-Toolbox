#! /usr/bin/env bash

set -e

echo "Clearing 'Logs'"
rm -f Logs/*
export LOGFILE=$PWD/Logs/CUDA.log

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

# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
pushd /tmp
rm -f *.deb

if [[ `uname --kernel-release` =~ "WSL2" ]]
then
  echo "WSL2 detected"
  wget --quiet \
    https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
else
  echo "Not WSL"
  wget --quiet \
    https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
fi
  sudo dpkg -i cuda-keyring_1.1-1_all.deb \
    >> $LOGFILE 2>&1
  sudo apt-get -qq update
  sudo apt-get -qqy upgrade \
    >> $LOGFILE 2>&1
  sudo apt-get -y install \
    cuda-toolkit-12-4 \
    >> $LOGFILE 2>&1
popd

echo "Finished"
