#! /usr/bin/env bash

set -e

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install --yes \
  cmake \
  flac \
  ffmpeg \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  libavfilter-dev \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libfftw3-doc \
  libfluidsynth-dev \
  libmagick++-dev \
  libsox-dev \
  libsox-fmt-all  \
  libsoxr-dev  \
  mp3splt \
  sox \
  >> Logs/3_audio_packages.log 2>&1

echo "Installing R audio packages - this takes some time"
/usr/bin/time ./audio_packages.R >> Logs/3_audio_packages.log 2>&1

echo "Finished"
