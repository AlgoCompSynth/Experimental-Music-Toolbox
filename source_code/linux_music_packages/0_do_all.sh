#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=Logs/linux_music_packages.log

echo ""
echo "Installing base multimedia tasks"
/usr/bin/time sudo apt-get install --assume-yes \
  alsa-utils \
  faust \
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
  multimedia-ambisonics \
  multimedia-csound \
  multimedia-puredata \
  multimedia-supercollider \
  nyquist \
  pipewire \
  polyphone \
  pulseaudio \
  pulseaudio-utils \
  python3-csound \
  qjackctl \
  sf3convert \
  sndfile-tools \
  sox \
  timidity \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
