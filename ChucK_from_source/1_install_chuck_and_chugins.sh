#! /usr/bin/env bash

set -e

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.2.4"

echo "Clearing Logs"
rm -f Logs/*
export LOGFILE=$PWD/Logs/chuck_and_chugins.log

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
  libsndfile1-dev \
  >> $LOGFILE 2>&1

echo "Cloning repositories"
rm -fr chuck
/usr/bin/time git clone --branch $CHUCK_VERSION \
  https://github.com/ccrma/chuck.git \
  >> $LOGFILE 2>&1
rm -fr chugins
/usr/bin/time git clone --branch $CHUCK_VERSION --recurse-submodules \
  https://github.com/ccrma/chugins.git \
  >> $LOGFILE 2>&1

echo "Building ChucK"
pushd chuck/src
/usr/bin/time make linux-all \
  >> $LOGFILE 2>&1
echo "Installing ChucK"
sudo make install
popd

echo "Building ChuGins"
pushd chugins
/usr/bin/time make linux \
  >> $LOGFILE 2>&1
echo "Installing ChuGins"
sudo make install
popd

echo "Finished"
