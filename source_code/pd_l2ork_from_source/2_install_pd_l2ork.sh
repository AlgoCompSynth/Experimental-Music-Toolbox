#! /usr/bin/env bash

set -e

echo "Setting Pd-L2Ork version"
export PD_L2ORK_VERSION="20241217"

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/2_install_pd_l2ork.log
rm --force $LOGFILE

echo "Cloning repository"
pushd /tmp
  rm --force --recursive pd-l2ork
  /usr/bin/time git clone --recurse-submodules --branch $PD_L2ORK_VERSION \
    https://github.com/pd-l2ork/pd-l2ork.git \
    >> $LOGFILE 2>&1
popd

echo ""
echo "Building Pd-L2Ork"
pushd /tmp/pd-l2ork
  /usr/bin/time make --jobs=`nproc` all \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing Pd-L2Ork"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
