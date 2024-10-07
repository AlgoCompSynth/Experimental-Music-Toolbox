#! /usr/bin/env bash

set -e

echo "Updating package cache"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get update \
  > unminimize.log 2>&1
echo "Upgrading packages"
/usr/bin/time sudo apt-get upgrade --assume-yes \
  >> unminimize.log 2>&1
/usr/bin/time sudo apt-get install --assume-yes \
  unminimize \
  >> unminimize.log 2>&1
echo "Restoring missing 'man' pages"
sudo touch /etc/dpkg/dpkg.cfg.d/excludes
echo "Y" | /usr/bin/time sudo unminimize \
  >> unminimize.log 2>&1
