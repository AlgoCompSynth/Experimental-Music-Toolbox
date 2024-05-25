#! /usr/bin/env bash

set -e

sudo touch /etc/dpkg/dpkg.cfg.d/excludes
echo "Y" | sudo unminimize > /dev/null 2>&1
