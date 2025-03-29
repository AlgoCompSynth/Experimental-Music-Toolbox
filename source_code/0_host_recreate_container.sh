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
export DBX_CONTAINER_IMAGE="docker.io/library/debian:testing-backports"
export DBX_CONTAINER_NAME="ExpMusTools-$COMPUTE_MODE"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes"
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
export DBX_CONTAINER_HOSTNAME=$DBX_CONTAINER_NAME

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
    --additional-packages "systemd libpam-systemd time vim" \
    --init
else
  distrobox create \
    --image $DBX_CONTAINER_IMAGE \
    --name $DBX_CONTAINER_NAME \
    --hostname $DBX_CONTAINER_HOSTNAME \
    --pull \
    --home $DBX_CONTAINER_DIRECTORY \
    --additional-packages "systemd libpam-systemd time vim" \
    --init
fi
  
echo ""
echo "Creating file './set_compute_mode.sh'"
echo "export COMPUTE_MODE=$COMPUTE_MODE" > ./set_compute_mode.sh
echo "'source' this file in scripts that need to know COMPUTE_MODE"
echo ""
echo "Entering $DBX_CONTAINER_NAME"
echo "You do *not* have to type the above 'distrobox enter' command!"
echo "This will take some time."
echo "It is downloading and installing basic packages."
echo ""
echo ""
distrobox enter "$DBX_CONTAINER_NAME"
