#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep
source ../set_envars

for script in \
  1_linux_dependencies.sh \
  2_install_pd_l2ork.sh
do
  ./$script
done
