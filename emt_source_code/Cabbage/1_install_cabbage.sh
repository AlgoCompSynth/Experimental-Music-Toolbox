#! /usr/bin/env bash

set -e

echo "Clearing 'Logs'"
rm -f Logs/*
export LOGFILE=$PWD/Logs/1_install_cabbage.log

export CABBAGE_VERSION="2.9.0"
export CABBAGE_URL="https://github.com/rorywalsh/cabbage/releases/download"

echo "Downloading Cabbage version $CABBAGE_VERSION"
pushd /tmp
rm -fr Cabbage; mkdir --parents Cabbage; cd Cabbage
wget --quiet $CABBAGE_URL/v$CABBAGE_VERSION/CabbageLinux-$CABBAGE_VERSION.zip
unzip CabbageLinux-$CABBAGE_VERSION.zip

echo "Installing"
sed -i.bak "s;/usr;$HOME/.local;" installCabbage.sh
./installCabbage.sh 2>&1 | tee $LOGFILE 2>&1
popd

echo "Finished"
