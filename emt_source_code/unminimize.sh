#! /usr/bin/env bash

set -e

echo "Setting empty list of excludes"
sudo touch /etc/dpkg/dpkg.cfg.d/excludes

echo "Logging to ./unminimize.log"
/usr/bin/time sudo unminimize 2>&1 \
  | tee ./unminimize.log

echo "Finished"
