#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep

for script in \
  1_reinstall_mambaforge.sh \
  2_recreate_conda_env.sh
do
  ./$script
done
