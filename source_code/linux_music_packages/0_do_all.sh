#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=Logs/1_noble_music_packages.log

echo ""
echo "Installing base multimedia tasks"
/usr/bin/time sudo apt-get install --yes \
  faust \
  iannix \
  multimedia-ambisonics \
  multimedia-csound \
  multimedia-puredata \
  multimedia-supercollider \
  nyquist \
  python3-csound \
  >> $LOGFILE 2>&1

echo "Finished"
