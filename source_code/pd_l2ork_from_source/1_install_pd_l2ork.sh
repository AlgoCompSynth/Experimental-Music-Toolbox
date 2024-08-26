#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/1_install_pd_l2ork.log

echo "Installing build dependencies"
sudo apt-get update -qq
/usr/bin/time sudo apt-get upgrade --yes \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install --yes \
  autoconf \
  automake \
  bison \
  blepvco \
  blop \
  build-essential \
  byacc \
  cmake \
  cmt \
  dssi-dev \
  dssi-utils \
  fil-plugins \
  flex \
  flite1-dev \
  fluid-soundfont-gm \
  git \
  invada-studio-plugins-ladspa \
  ladspa-sdk \
  libasound2-dev \
  libavifile-0.7-dev \
  libbluetooth-dev \
  libdc1394-dev \
  libfftw3-dev \
  libfluidsynth-dev \
  libftgl-dev \
  libgl1-mesa-dev \
  libglew-dev \
  libglu1-mesa-dev \
  libgmerlin-avdec-dev \
  libgmerlin-dev \
  libgsl0-dev \
  libgsm1-dev \
  libgtk2.0-dev \
  libjack-jackd2-dev \
  libjpeg-dev \
  liblua5.3-dev \
  libmagick++-dev \
  libmp3lame-dev \
  libmpeg3-dev \
  libnss3 \
  libquicktime-dev \
  libraw1394-dev \
  libsmpeg0 \
  libspeex-dev \
  libstk-dev \
  libtirpc-dev \
  libtool \
  libv4l-dev \
  libvorbis-dev \
  mcp-plugins \
  mda-lv2 \
  ninja-build \
  omins \
  patchelf \
  portaudio19-dev \
  python3-dev \
  rev-plugins \
  rsync \
  swh-plugins \
  tap-plugins \
  vco-plugins \
  wah-plugins \
  wget \
  >> $LOGFILE 2>&1

mkdir --parents $HOME/Projects
pushd $HOME/Projects
  echo "Cloning repository"
  rm -fr pd-l2ork
  /usr/bin/time git clone \
    https://github.com/pd-l2ork/pd-l2ork.git \
    >> $LOGFILE 2>&1

  pushd pd-l2ork
    echo "Building Pd-L2Ork"
    /usr/bin/time make -j`nproc` incremental \
    >> $LOGFILE 2>&1

    echo "Installing Pd-L2Ork"
    sudo make install
  popd

popd

echo "Finished"
