#! /usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

echo "Defining LOGFILE"
export LOGFILE=$PWD/1_global_installs.log
rm --force $LOGFILE

echo "Adding $USER to the 'audio' and 'jackuser' groups"
sudo usermod -aG audio $USER
sudo addgroup --system jackuser
sudo usermod -aG jackuser $USER

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

sudo apt-get install -qqy jackd2

echo "Installing base packages"
/usr/bin/time sudo apt-get install --assume-yes \
  alsa-tools \
  alsa-utils \
  apt-file \
  build-essential \
  dirmngr \
  ffmpeg \
  file \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  git-lfs \
  gpg-agent \
  libasound2-plugins \
  libcanberra-gtk3-module \
  libsox-fmt-all \
  libsoxr0 \
  lsb-release \
  lynx \
  mp3splt \
  pciutils \
  pipewire \
  plocate \
  polyphone \
  pulseaudio \
  pulseaudio-utils \
  qjackctl \
  sf3convert \
  sndfile-tools \
  sox \
  timidity \
  tree \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
