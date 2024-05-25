#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents Logs
touch Logs/.gitkeep
export LOGFILE=Logs/1_Noble_music_packages.log

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
echo "Installing music packages"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  alsa-utils \
  amb-plugins \
  ardour \
  audacity \
  cecilia \
  csound \
  csound-doc \
  csound-plugins \
  csound-soundfont \
  csound-utils \
  csoundqt \
  csoundqt-examples \
  faust \
  faustworks \
  ffmpeg \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  gem \
  iannix \
  libambix-dev \
  libambix-doc \
  libambix-utils \
  liblo-dev \
  liblo-tools \
  lua-luacsnd6 \
  mikmod \
  musescore-general-soundfont-lossless \
  musescore3 \
  pd-iem \
  polyphone \
  puredata \
  puredata-dev \
  puredata-doc \
  puredata-extra \
  puredata-gui \
  puredata-import \
  puredata-utils \
  puredata64 \
  python3-csound \
  sc3-plugins \
  sc3-plugins-language \
  sc3-plugins-server \
  sf3convert \
  sonic-pi \
  sonic-pi-samples  \
  sonic-pi-server  \
  sonic-pi-server-doc \
  soundscaperenderer \
  stk \
  stk-doc \
  supercollider \
  supercollider \
  supercollider-ide \
  supercollider-language \
  supercollider-server \
  supercollider-supernova \
  supercollider-vim \
  swami \
  >> $LOGFILE 2>&1

echo ""
echo "Installing 'pd-*'"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  "pd-*" \
  >> $LOGFILE 2>&1

echo "Finished"
