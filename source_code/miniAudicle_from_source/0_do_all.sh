#! /usr/bin/env bash

set -e

source ../set_envars
echo "Setting Qt version"
export QT_SELECT=qt6

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/install_miniaudicle.log

echo "Installing build dependencies"
sudo apt-get update -qq
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

echo "Cloning repository"
pushd /tmp
rm -fr miniAudicle
/usr/bin/time git clone --recurse-submodules --branch $CHUCK_VERSION \
  https://github.com/ccrma/miniAudicle.git \
  >> $LOGFILE 2>&1

echo ""
echo "Building ChucK"
pushd miniAudicle/src/chuck/src
/usr/bin/time make linux-pulse \
  >> $LOGFILE 2>&1
echo ""
echo "Installing ChucK"
sudo make install \
  >> $LOGFILE 2>&1
popd

echo ""
echo "Building ChuGins"
pushd miniAudicle/src/chugins
/usr/bin/time make linux \
  >> $LOGFILE 2>&1
echo ""
echo "Installing ChuGins"
sudo make install \
  >> $LOGFILE 2>&1
popd

echo ""
echo "Building miniAudicle"
pushd miniAudicle/src
/usr/bin/time make linux-pulse \
  >> $LOGFILE 2>&1
echo ""
echo "Installing miniAudicle"
sudo make install \
  >> $LOGFILE 2>&1
popd

popd

echo "Finished"
