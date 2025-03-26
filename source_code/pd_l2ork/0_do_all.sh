#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep
source ../set_envars

for script in \
  1_install_pd_l2ork_from_source.sh
do
  ./$script
done
