#! /usr/bin/env bash

set -e

# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

export HOSTNAME=`hostname`
echo "HOSTNAME: $HOSTNAME"
if [[ "$HOSTNAME" =~ "CPU" ]]
then
  echo "Exit -1024: a 'CPU' distrobox has no NVIDIA drivers"
  exit -1024
fi

DISTRIBUTOR=`lsb_release -is | grep -v "No LSB modules"`
CODENAME=`lsb_release -cs | grep -v "No LSB modules"`

echo "DISTRIBUTOR: $DISTRIBUTOR"
echo "CODENAME: $CODENAME"

if [ "$CODENAME" == "bookworm" ]
then

  # Bookworm
  export HERE=$PWD
  lspci \
  > $HERE/Logs/cuda-toolkit.log 2>&1

  echo "..adding repository"
  pushd /tmp
  rm -f *.deb
  wget --quiet https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
  sudo dpkg -i cuda-keyring_1.1-1_all.deb \
  >> $HERE/Logs/cuda-toolkit.log 2>&1
  sudo add-apt-repository -y contrib \
  >> $HERE/Logs/cuda-toolkit.log 2>&1
  sudo apt-get update -qq
  echo "..installing CUDA toolkit"
  /usr/bin/time sudo apt-get -qqy --no-install-recommends install cuda-toolkit-12-4 \
  >> $HERE/Logs/cuda-toolkit.log 2>&1
  popd

else

  echo "..exit -1024 Only Debian 'bookworm' is currently supported"
  exit -1024

fi

echo "Finished"
