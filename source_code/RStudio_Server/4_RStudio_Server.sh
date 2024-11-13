#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/4_RStudio_Server.log

echo ""
echo "Installing gdebi-core"
# https://posit.co/download/rstudio-server/
/usr/bin/time sudo apt-get install --yes \
  gdebi-core \
  >> $LOGFILE 2>&1

echo ""
echo "Installing RStudio Server"
pushd /tmp
rm -f *.deb

# https://posit.co/download/rstudio-server/
export RSTUDIO_SERVER_PACKAGE="rstudio-server-2024.09.1-394-amd64.deb"
wget --quiet https://download2.rstudio.org/server/jammy/amd64/$RSTUDIO_SERVER_PACKAGE
/usr/bin/time sudo gdebi -n -q $RSTUDIO_SERVER_PACKAGE \
  >> $LOGFILE 2>&1
popd

echo ""
echo ""
echo "Reconfiguring RStudio Server:"
echo "1. Listen only on 127.0.0.1 (localhost), port 8787."
echo "2. Turn on debug logging."
echo ""
echo "To change these, edit the files 'rserver.conf' and"
echo "'logging.conf' and re-run the script"
echo ""
echo "    ./reconfigure_RStudio_Server.sh"
echo ""
./reconfigure_RStudio_Server.sh

echo ""
echo "Adding $USER to the 'systemd-journal' group"
sudo usermod -a -G systemd-journal $USER

echo ""
echo "Finished!"

echo ""
echo ""
echo "If you are running RStudio Server in a container, you"
echo "will need to set a password for your username."
echo "Use the script"
echo ""
echo "    ./set_password.sh"
echo ""
echo "to do that."
