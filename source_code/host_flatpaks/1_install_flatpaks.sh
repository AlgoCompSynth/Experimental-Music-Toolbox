#! /usr/bin/env bash

set -e

echo "Installing Flatpaks"
/usr/bin/time sudo flatpak install \
  org.audacityteam.Audacity \
  org.musescore.MuseScore \
  io.github.pd_l2ork.Pd_L2Ork

echo "Finished"
