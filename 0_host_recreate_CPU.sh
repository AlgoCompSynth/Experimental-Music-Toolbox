#! /usr/bin/env bash

set -e

export COMPUTE_MODE=CPU
echo ""
echo "COMPUTE_MODE: $COMPUTE_MODE"
echo ""
echo "Setting environment variables"
source ./set_dbx_envars
set | grep "^DBX"
echo ""

echo "Removing any existing $DBX_CONTAINER_NAME"
distrobox rm --force $DBX_CONTAINER_NAME

echo "Removing any existing $DBX_CONTAINER_DIRECTORY"
rm -rf $DBX_CONTAINER_DIRECTORY

echo "Pulling $DBX_CONTAINER_IMAGE"
podman pull $DBX_CONTAINER_IMAGE

echo "Creating distrobox $DBX_CONTAINER_NAME"
distrobox create \
  --image $DBX_CONTAINER_IMAGE \
  --name $DBX_CONTAINER_NAME \
  --hostname $DBX_CONTAINER_HOSTNAME \
  --pull \
  --home $DBX_CONTAINER_DIRECTORY \
  --additional-packages "systemd libpam-systemd apt-file file git-lfs lsb-release pciutils plocate software-properties-common time tree vim-nox" \
  --additional-packages "fftw-dev fftw-docs libfftw3-bin libfftw3-dev libfftw3-doc libfftw3-mpi-dev libopenblas64-pthread-dev" \
  --init
  
echo "Entering $DBX_CONTAINER_NAME"
echo "Installing the basic packages will take some time"
distrobox enter "$DBX_CONTAINER_NAME"
