#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep

for script in \
  1_RStudio_Server.sh \
  2_developer_packages.sh \
  3_audio_packages.sh
do
  ./$script
done
