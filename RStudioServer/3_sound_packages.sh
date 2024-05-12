#! /usr/bin/env bash

set -e

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  cmake \
  flac \
  ffmpeg \
  libfftw3-dev \
  libfftw3-doc \
  libsox-dev \
  libsox-fmt-all  \
  libsoxr-dev  \
  mp3splt \
  sox \
  > Logs/3_sound_packages.log 2>&1

echo "Installing sound R packages - this takes some time"
/usr/bin/time ./sound_packages.R >> Logs/3_sound_packages.log 2>&1

echo "Finished"


