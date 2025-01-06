#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm -f Logs/*
touch Logs/.gitkeep
source ../set_envars

for script in \
  1_R_and_Quarto_CLI.sh \
  2_developer_packages.sh \
  3_audio_packages.sh \
  4_RStudio_Server.sh
do
  ./$script
done
