#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=Logs/linux_music_packages.log

echo ""
echo "Installing multimedia tasks"
/usr/bin/time sudo apt-get install --assume-yes \
  faust \
  multimedia-ambisonics \
  multimedia-csound \
  multimedia-puredata \
  multimedia-supercollider \
  nyquist \
  python3-csound \
  >> $LOGFILE 2>&1

echo "Finished"
