#! /usr/bin/env bash

set -e

echo "Adding git PPA"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo add-apt-repository --yes \
  ppa:git-core/ppa
