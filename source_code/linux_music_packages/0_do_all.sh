#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep
source ../set_envars

for script in \
  1_linux_music_packages.sh
do
  ./$script
done
