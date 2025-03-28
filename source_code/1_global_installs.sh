#! /usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

echo "Defining LOGFILE"
export LOGFILE=$PWD/1_global_installs.log
rm --force $LOGFILE

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo ""
echo ""
echo "Installing 'jackd2' first. There appears to be no way"
echo "to keep it from configuring the realtime process priority"
echo "option when the install runs in the background."
echo ""
echo "The default of 'No' is safest; if you want to experiment"
echo "with realtime priority later, you can change it by running"
echo ""
echo "    sudo dpkg-reconfigure jackd2"
echo ""
read -p "Press 'Enter' to continue:"

sudo apt-get install -qqy jackd2

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
  libcanberra-gtk3-module \
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
  qjackctl \
  tree \
  >> $LOGFILE 2>&1

echo "Finished"
