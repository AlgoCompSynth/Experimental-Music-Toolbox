#! /usr/bin/env bash

set -e

echo "Clearing 'Logs'"
rm -f Logs/*
export LOGFILE=Logs/1_linux_music_packages.log

echo ""
echo ""
echo "Installing 'jackd2' first. There appears to be no way"
echo "to keep it from configuring the realtime process priority"
echo "option when the install runs in the background."
echo ""
echo "The default of 'No' is safest; if you want to experiment"
echo "with realtime priority later, you can change it by running"
echo ""
echo "    sudo dpkg-reconfigure jackd2"
echo ""
read -p "Press 'Enter' to continue:"

sudo apt-get install -qqy --no-install-recommends jackd2

echo ""
echo ""
echo "Setting non-interactive mode"
export DEBIAN_FRONTEND=noninteractive

echo ""
echo "Installing multimedia-tasks"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  multimedia-tasks \
  >> $LOGFILE 2>&1

echo "...csound"
/usr/bin/time sudo apt-get install -qqy multimedia-csound > Logs/csound.log 2>&1

echo "...puredata"
/usr/bin/time sudo apt-get install -qqy multimedia-puredata > Logs/puredata.log 2>&1

echo "...supercollider"
/usr/bin/time sudo apt-get install -qqy multimedia-supercollider > Logs/supercollider.log 2>&1

echo ""
echo "Installing other tools"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  audacity \
  faust \
  faustworks \
  fluidsynth \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  freepats \
  liblo-dev \
  liblo-tools \
  musescore-general-soundfont-lossless \
  musescore3 \
  nyquist \
  polyphone \
  sf3convert \
  sonic-pi \
  sonic-pi-samples  \
  sonic-pi-server  \
  sonic-pi-server-doc \
  stk \
  stk-doc \
  swami \
  >> $LOGFILE 2>&1

echo "Finished"
