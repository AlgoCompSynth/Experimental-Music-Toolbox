#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/unminimize.log
rm --force $LOGFILE

echo "Updating package cache"
/usr/bin/time sudo apt-get update \
  >> $LOGFILE 2>&1

echo "Upgrading packages"
/usr/bin/time sudo apt-get upgrade --assume-yes \
  >> $LOGFILE 2>&1

echo "Restoring missing 'man' pages"
sudo touch /etc/dpkg/dpkg.cfg.d/excludes
echo "Y" | /usr/bin/time sudo unminimize \
  >> $LOGFILE 2>&1
