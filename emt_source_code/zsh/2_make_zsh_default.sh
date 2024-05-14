#! /bin/bash

set -e

echo "Setting shell with 'usermod --shell'"
sudo usermod --shell zsh $USER
echo ""
echo "Finished"
