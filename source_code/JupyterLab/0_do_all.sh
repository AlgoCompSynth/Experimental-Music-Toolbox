#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep

for script in \
  1_reinstall_miniforge3.sh \
  2_recreate_conda_env.sh
do
  ./$script
done
