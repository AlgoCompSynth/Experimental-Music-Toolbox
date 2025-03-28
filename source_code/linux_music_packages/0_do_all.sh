#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=Logs/1_noble_music_packages.log

echo ""
echo "Installing base multimedia tasks"
/usr/bin/time sudo apt-get install --yes \
  multimedia-ambisonics \
  multimedia-csound \
  multimedia-jack \
  multimedia-puredata \
  multimedia-supercollider \
  multimedia-tasks \
  >> $LOGFILE 2>&1

echo "Installing additional audio packages"
/usr/bin/time sudo apt-get install --yes \
  faust \
  ffmpeg \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  iannix \
  libavfilter-dev \
  libfftw3-dev \
  libfftw3-doc \
  liblo-dev \
  liblo-tools \
  libsox-dev \
  libsox-fmt-all \
  libsoxr-dev \
  mp3splt \
  nyquist \
  pipewire \
  polyphone \
  python3-csound \
  sf3convert \
  sonic-pi \
  sox \
  stk \
  stk-doc \
  supercollider \
  timidity \
  >> $LOGFILE 2>&1

echo "Finished"
