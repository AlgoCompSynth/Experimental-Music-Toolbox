#! /usr/bin/env bash

set -e

echo "Setting password for $USER - RStudio Server needs it"
sudo passwd $USER

echo "Finished!"
