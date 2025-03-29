#! /usr/bin/env bash

set -e

for option in \
  RStudio_Server \
  JupyterLab \
  linux_music_packages \
  miniAudicle_from_source \
  pd_l2ork \
  vcvrack_dev
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./0_do_all.sh
  popd
done
