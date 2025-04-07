#! /usr/bin/env bash

set -e

source ../set_envars
echo "Setting Qt version"
export QT_SELECT=qt6

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_miniaudicle.log
rm --force $LOGFILE

echo "Installing build dependencies"
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get upgrade --yes \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install --yes \
  alsa-utils \
  bison \
  build-essential \
  flex \
  libasound2-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libqscintilla2-qt6-dev \
  qt6-base-dev \
  qt6-wayland \
  qt6-wayland-dev \
  libsndfile1-dev \
  >> $LOGFILE 2>&1
export PATH=/usr/lib/qt6/bin:$PATH

mkdir --parents $HOME/Projects
pushd $HOME/Projects
  echo ""
  echo "Cloning repository"
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chuck/src
  echo ""
  echo "Building ChucK"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-all \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chugins
  echo ""
  echo "Building ChuGins"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src
  echo ""
  echo "Building miniAudicle"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-all \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing miniAudicle"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
