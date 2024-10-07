#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep

for script in \
  1_noble_music_packages.sh
do
  ./$script
done
