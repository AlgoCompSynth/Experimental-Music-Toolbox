#! /usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

./add_git_ppa.sh

if [ -x "/usr/bin/distrobox-export" ]
then
  # not on WSL - we need to unminimize
  echo "Running in a Distrobox container - restoring missing documentation"
  ./unminimize.sh
  echo ""
fi

echo "Defining LOGFILE"
export LOGFILE=$PWD/1_global_installs.log
rm --force $LOGFILE

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Installing base packages"
/usr/bin/time sudo apt-get install --assume-yes \
  apt-file \
  build-essential \
  dirmngr \
  fftw-dev \
  fftw-docs \
  file \
  git-lfs \
  gpg-agent \
  libfftw3-bin \
  libfftw3-dev \
  libfftw3-doc \
  libfftw3-mpi-dev \
  libopenblas-pthread-dev \
  libopenblas64-pthread-dev \
  lsb-release \
  lynx \
  pciutils \
  plocate \
  tree \
  >> $LOGFILE 2>&1

echo "Finished"
