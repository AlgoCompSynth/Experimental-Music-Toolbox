#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents Logs
touch Logs/.gitkeep
export LOGFILE=Logs/1_debian_music_packages.log

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
echo "Installing multimedia tasks"
/usr/bin/time sudo apt-get install -qqy \
  multimedia-tasks \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install -qqy \
  multimedia-ambisonics \
  multimedia-csound \
  multimedia-puredata \
  multimedia-supercollider \
  >> $LOGFILE 2>&1

echo ""
echo "Installing additional packages"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  audacity \
  faust \
  faustworks \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  iannix \
  libambix-dev \
  libambix-doc \
  libambix-utils \
  liblo-dev \
  liblo-tools \
  musescore-general-soundfont-lossless \
  musescore3 \
  polyphone \
  python3-csound \
  sf3convert \
  stk \
  stk-doc \
  swami \
  >> $LOGFILE 2>&1

echo "Finished"
