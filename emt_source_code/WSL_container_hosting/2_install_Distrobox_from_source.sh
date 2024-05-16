#! /usr/bin/env bash

set -e

if ! [[ `uname --kernel-release` =~ "WSL2" ]]
then
  echo "WSL2 not detected"
  echo "..exit -1024: container hosting is only supported on WSL2"
  exit -1024
fi

export LOGFILE=$PWD/Logs/2_install_Distrobox.log
export REPOSITORIES=$HOME/.local/repositories
export DISTROBOX_VERSION="1.7.2.1"

echo "Installing Distrobox"
echo "Creating directory for source repositories: $REPOSITORIES"
mkdir --parents $REPOSITORIES

echo "Cloning Distrobox source"
pushd $REPOSITORIES
rm -fr distrobox
/usr/bin/time git clone --branch $DISTROBOX_VERSION --recursive https://github.com/89luca89/distrobox.git \
  >> $LOGFILE 2>&1

echo "Installing Distrobox"
cd distrobox
./install

popd

echo "Finished"
