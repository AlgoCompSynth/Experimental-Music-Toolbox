#! /usr/bin/env bash

set -e

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.2.4"

echo "Clearing Logs"
mkdir --parents Logs
rm -f Logs/*
export LOGFILE=$PWD/Logs/1_install_miniaudicle.log

echo "Installing build dependencies"
sudo apt-get update -qq
/usr/bin/time sudo apt-get upgrade -qqy \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  bison \
  build-essential \
  flex \
  libasound2-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libqscintilla2-qt6-dev \
  qt6-base-dev \
  libsndfile1-dev \
  >> $LOGFILE 2>&1

echo ""
echo "Defining 'qmake' with a symlink"
ln -sf /usr/bin/qmake6 $HOME/.local/bin/qmake
echo ""

echo "Cloning repository"
rm -fr miniAudicle
/usr/bin/time git clone --recurse-submodules --branch $CHUCK_VERSION \
  https://github.com/ccrma/miniAudicle.git
  >> $LOGFILE 2>&1

echo "Building miniAudicle for pulseaudio"
export QT_SELECT=qt6
pushd miniAudicle/src
/usr/bin/time make linux-pulse
  >> $LOGFILE 2>&1
echo "Installing miniAudicle"
sudo make install
popd

echo "Finished"
