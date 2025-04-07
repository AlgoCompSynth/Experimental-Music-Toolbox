#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_vcvrack_from_source.log
rm --force $LOGFILE

echo "Installing build dependencies"
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get upgrade --yes \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install --yes \
  cmake \
  curl \
  gdb \
  git \
  jq \
  libasound2-dev \
  libglu1-mesa-dev \
  libgtk2.0-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libx11-dev \
  libxcursor-dev \
  libxi-dev zlib1g-dev \
  libxinerama-dev \
  libxrandr-dev \
  >> $LOGFILE 2>&1

mkdir --parents $HOME/Projects
pushd $HOME/Projects
  echo "Cloning repositories"
  rm --force --recursive Rack VCVBook
  /usr/bin/time git clone \
    https://github.com/VCVRack/Rack.git \
    >> $LOGFILE 2>&1
  /usr/bin/time git clone \
    https://github.com/LOGUNIVPM/VCVBook.git \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/Rack
  echo "Fetching Rack submodules"
  /usr/bin/time git submodule update --init --recursive \
    >> $LOGFILE 2>&1

  echo "make dep"
  /usr/bin/time make dep \
    >> $LOGFILE 2>&1

  echo "make"
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1

popd

cp -rp $HOME/Projects/VCVBook/ABC $HOME/Projects/Rack/plugins

pushd $HOME/Projects/Rack/plugins/ABC
  echo "Building ABC plugin"
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
popd

echo "Finished"
