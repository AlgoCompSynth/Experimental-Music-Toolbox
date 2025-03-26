#! /usr/bin/env bash

set -e

for option in \
  linux_music_packages \
  miniAudicle_from_source \
  RStudio_Server \
  JupyterLab \
  pd_l2ork
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./0_do_all.sh
  popd
done
