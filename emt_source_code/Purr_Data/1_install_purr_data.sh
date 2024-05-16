#! /usr/bin/env bash

set -e

echo "Clearing 'Logs'"
rm -f Logs/*
export LOGFILE=$PWD/Logs/1_install_purr_data.log

export PURR_DATA_VERSION="2.19.3"
export PURR_DATA_URL="https://github.com/agraef/purr-data/releases/download"

echo "Downloading Purr Data version $PURR_DATA_VERSION"
pushd /tmp
rm -f *.zip *.deb
wget --quiet $PURR_DATA_URL/$PURR_DATA_VERSION/purr-data-$PURR_DATA_VERSION-ubuntu-x86_64.zip
unzip purr-data-$PURR_DATA_VERSION-ubuntu-x86_64.zip

echo "Installing"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  ./purr-data_$PURR_DATA_VERSION*_amd64.deb \
  > $LOGFILE 2>&1
popd

echo "Finished"
