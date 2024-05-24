#! /usr/bin/env bash

set -e

echo ""
echo "Stopping RStudio Server - you can ignore error messages"
sudo systemctl stop rstudio-server.service || true
sleep 10

echo "Installing configuration file 'rserver.conf':"
sudo mkdir --parents /etc/rstudio
sudo cp rserver.conf /etc/rstudio/

echo "Installing logging configuration file 'logging.conf'"
sudo cp logging.conf /etc/rstudio/

echo "Restarting RStudio Server"
sudo systemctl enable --now rstudio-server.service 
