#! /usr/bin/env bash

set -e

echo "Updating package cache"
sudo apt-get update \
  > unminimize.log 2>&1
echo "U[grading packages"
sudo apt-get upgrade -y \
  >> unminimize.log 2>&1
echo "Restoring missing documentattion"
sudo touch /etc/dpkg/dpkg.cfg.d/excludes
echo "Y" | sudo unminimize \
  >> unminimize.log 2>&1
