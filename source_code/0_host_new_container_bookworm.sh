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

echo ""
echo "Setting environment variables"
export DBX_CONTAINER_IMAGE="quay.io/toolbx-images/debian-toolbox:12"
export DBX_CONTAINER_NAME="EMT-$COMPUTE_MODE"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes"
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
export DBX_CONTAINER_HOSTNAME="EMT-$COMPUTE_MODE"

echo ""
echo "Removing any existing distrobox container $DBX_CONTAINER_NAME"
distrobox rm --force $DBX_CONTAINER_NAME

echo "Removing any existing distrobox home directory $DBX_CONTAINER_DIRECTORY"
rm -rf $DBX_CONTAINER_DIRECTORY

echo "Pulling $DBX_CONTAINER_IMAGE"
podman pull $DBX_CONTAINER_IMAGE

echo "Creating distrobox $DBX_CONTAINER_NAME"
if [ "$COMPUTE_MODE" == "CUDA" ]
then
  distrobox create \
    --nvidia \
    --image $DBX_CONTAINER_IMAGE \
    --name $DBX_CONTAINER_NAME \
    --hostname $DBX_CONTAINER_HOSTNAME \
    --pull \
    --home $DBX_CONTAINER_DIRECTORY \
    --additional-packages "systemd libpam-systemd" \
    --additional-packages "apt-file file git-lfs lsb-release lynx pciutils plocate software-properties-common time tree vim-nox" \
    --additional-packages "fftw-dev fftw-docs libfftw3-bin libfftw3-dev libfftw3-doc libfftw3-mpi-dev libopenblas64-pthread-dev" \
    --init
else
  distrobox create \
    --image $DBX_CONTAINER_IMAGE \
    --name $DBX_CONTAINER_NAME \
    --hostname $DBX_CONTAINER_HOSTNAME \
    --pull \
    --home $DBX_CONTAINER_DIRECTORY \
    --additional-packages "systemd libpam-systemd" \
    --additional-packages "apt-file file git-lfs lsb-release lynx pciutils plocate software-properties-common time tree vim-nox" \
    --additional-packages "fftw-dev fftw-docs libfftw3-bin libfftw3-dev libfftw3-doc libfftw3-mpi-dev libopenblas64-pthread-dev" \
    --init
fi
  
echo ""
echo "Creating file './set_compute_mode.sh'"
echo "export COMPUTE_MODE=$COMPUTE_MODE" > ./set_compute_mode.sh
echo "'source' this file in scripts that need to know COMPUTE_MODE"
echo ""
echo "Entering $DBX_CONTAINER_NAME"
distrobox enter "$DBX_CONTAINER_NAME"
