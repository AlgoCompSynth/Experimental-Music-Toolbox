#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/3_audio_base.log"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
echo ""
echo ""
echo "Installing 'jackd2'. There appears to be no way to keep"
echo "it from configuring the realtime process priority"
echo "option when the install runs in the background."
echo ""
echo "The default of 'No' is safest; if you want to experiment"
echo "with realtime priority later, you can change it by running"
echo ""
echo "    sudo dpkg-reconfigure jackd2"
echo ""
read -p "Press 'Enter' to continue:"

/usr/bin/time sudo apt-get install -qqy --no-install-recommends jackd2

echo ""
echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo ""
echo "Installing base audio packages"
/usr/bin/time sudo apt-get install --assume-yes \
  alsa-utils \
  ffmpeg \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  iannix \
  jack-tools \
  libasound2-plugins \
  libsox-fmt-all \
  libsoxr0 \
  mp3splt \
  pipewire \
  polyphone \
  pulseaudio \
  pulseaudio-utils \
  qjackctl \
  sf3convert \
  sndfile-tools \
  sox \
  timidity \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
