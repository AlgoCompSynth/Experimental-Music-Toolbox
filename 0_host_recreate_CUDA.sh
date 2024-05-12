#! /usr/bin/env bash

set -e

export COMPUTE_MODE=CPU
echo "COMPUTE_MODE: $COMPUTE_MODE"

echo "(Re)creating distrobox"
distrobox assemble create --replace --file distrobox-$COMPUTE_MODE.ini

echo "Entering EMT-Bookworm-$COMPUTE_MODE"
echo "Installing the basic packages will take some time"
distrobox enter "EMT-Bookworm-$COMPUTE_MODE"
