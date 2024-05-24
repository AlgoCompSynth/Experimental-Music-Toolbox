#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents Logs
touch Logs/.gitkeep
export LOGFILE=$PWD/Logs/1_install_pd_l2ork.log

export PD_L2ORK_VERSION="20240329"
echo "Installing build dependencies"
sudo apt-get update -qq
/usr/bin/time sudo apt-get upgrade -qqy \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  automake \
  bison \
  blepvco \
  blop \
  byacc \
  cmake \
  cmt \
  dssi-dev \
  dssi-utils \
  fakeroot \
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

echo "Cloning repository"
pushd /tmp
rm -fr pd-l2ork
/usr/bin/time git clone --branch $PD_L2ORK_VERSION \
  https://github.com/pd-l2ork/pd-l2ork.git \
  >> $LOGFILE 2>&1

echo ""
echo "Building Pd-L2Ork"
pushd pd-l2ork
/usr/bin/time make all \
  >> $LOGFILE 2>&1
sudo make install /
  >> $LOGFILE 2>&1
popd

popd

echo "Finished"
