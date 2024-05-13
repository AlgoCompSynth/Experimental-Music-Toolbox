#! /usr/bin/env bash

set -e

sudo apt-get update -qq
sudo apt-get upgrade -qqy
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  fftw-dev \
  fftw-docs \
  file \
  git-lfs \
  libfftw3-bin \
  libfftw3-dev \
  libfftw3-doc \
  libfftw3-mpi-dev \
  libopenblas64-pthread-dev \
  lsb-release \
  pciutils \
  software-properties-common \
  time \
  tree \
  vim-nox
