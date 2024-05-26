#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/2_developer_packages.log

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install --yes \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libmagick++-dev \
  libpng-dev \
  libtiff5-dev \
  libxml2-dev \
  >> $LOGFILE 2>&1

echo "Installing R developer packages - this takes some time"
/usr/bin/time ./developer_packages.R \
  >> $LOGFILE 2>&1

echo "Finished"
