#! /usr/bin/env bash

set -e

export COMPUTE_MODE=""
while [ ${#COMPUTE_MODE} -lt "3" ]
do
  read -p "Enter the compute mode: CPU or CUDA:"
  if [ "$REPLY" == "CPU" ]
  then
    export COMPUTE_MODE=$REPLY
    break
  elif [ "$REPLY" == "CUDA" ]
  then
    export COMPUTE_MODE=$REPLY
    break
  else
    continue
  fi
done

echo "COMPUTE_MODE: $COMPUTE_MODE"

echo "Upgrading"
sudo apt-get update -qq
sudo apt-get upgrade -qqy

# duplicate of what's added to a base image
echo "Installing base packages"
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  dirmngr \
  fftw-dev \
  fftw-docs \
  file \
  git-lfs \
  gpg-agent \
  libfftw3-bin \
  libfftw3-dev \
  libfftw3-doc \
  libfftw3-mpi-dev \
  libopenblas-pthread-dev \
  libopenblas64-pthread-dev \
  libpam-systemd \
  lsb-release \
  lynx \
  pciutils \
  plocate \
  software-properties-common \
  systemd \
  time \
  tree \
  vim-nox \
  zsh

echo ""
echo "Creating file './set_compute_mode.sh'"
echo "export COMPUTE_MODE=$COMPUTE_MODE" > ./set_compute_mode.sh
echo "'source' this file in scripts that need to know COMPUTE_MODE"
echo ""

echo "Finished"
