#! /usr/bin/env bash

set -e

echo ""
echo "Testing man pages..."
echo "If you see a man page for 'bash', you do not need to run 'unminimize'."
echo ""
echo ""
sleep 5
man bash
echo "If you saw a man page for 'bash', you do not need to run 'unminimize'."
echo "If you got a message saying the system is minimized,"
echo "you can exit with CTL-C during the next 20 second sleep,"
echo "or let this script proceed and answer 'y'."
sleep 20
echo "Setting empty list of excludes"
sudo touch /etc/dpkg/dpkg.cfg.d/excludes

echo "Logging to ./unminimize.log"
/usr/bin/time sudo unminimize 2>&1 \
  | tee ./unminimize.log

echo "Finished"
