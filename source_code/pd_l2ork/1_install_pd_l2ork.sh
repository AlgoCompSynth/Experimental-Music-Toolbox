#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/1_install_pd_l2ork.log
rm --force $LOGFILE

pushd /tmp
  echo "Downloading $PD_L2ORK_URL"
  rm --force Pd-L2Ork-*.deb
  curl -sOL $PD_L2ORK_URL

  echo "Installing $PD_L2ORK_PACKAGE"
  sudo dpkg --install $PD_L2ORK_PACKAGE \
    >> $LOGFILE 2>&1
popd

echo "Finished"
