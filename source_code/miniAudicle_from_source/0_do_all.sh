#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep

for script in \
  1_install_miniaudicle.sh
do
  ./$script
done
