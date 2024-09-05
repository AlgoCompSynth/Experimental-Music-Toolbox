#! /usr/bin/env bash

set -e

for option in \
  apt_music_packages \
  miniAudicle_from_source \
  RStudio_Server \
  JupyterLab
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./0_do_all.sh
  popd
done
