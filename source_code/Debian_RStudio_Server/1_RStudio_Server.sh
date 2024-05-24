#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents Logs
touch Logs/.gitkeep
export LOGFILE=$PWD/Logs/1_RStudio_Server.log

DISTRIBUTOR=`lsb_release -is | grep -v "No LSB modules"`
CODENAME=`lsb_release -cs | grep -v "No LSB modules"`

echo ""
echo "Running on $DISTRIBUTOR $CODENAME"

if [ "$CODENAME" != "bookworm" ]
then

  echo "..exit -1024 Only Debian 'bookworm' is currently supported"
  exit -1024

fi

echo "Adding CRAN repository"
# https://cran.rstudio.com/bin/linux/debian/#secure-apt

gpg --keyserver keyserver.ubuntu.com \
    --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | \
    sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc
sudo cp bookworm.list /etc/apt/sources.list.d/

echo ""
echo "Installing R and gdebi-core"
# https://posit.co/download/rstudio-server/
sudo apt-get update -qq
/usr/bin/time sudo apt-get upgrade -qqy \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  gdebi-core \
  r-base \
  r-base-dev \
  >> $LOGFILE 2>&1
echo ""
echo "R --version: `R --version`"
echo ""
echo ""

echo "Setting R profile $HOME/.Rprofile"
cp Rprofile $HOME/.Rprofile
echo ""

echo ""
echo "Installing RStudio Server"
pushd /tmp
rm -f *.deb

# https://posit.co/download/rstudio-server/
export RSTUDIO_SERVER_PACKAGE="rstudio-server-2024.04.0-735-amd64.deb"
wget --quiet https://download2.rstudio.org/server/jammy/amd64/$RSTUDIO_SERVER_PACKAGE
/usr/bin/time sudo gdebi -n -q $RSTUDIO_SERVER_PACKAGE \
  >> $LOGFILE 2>&1

echo ""
echo "Installing Quarto CLI"
export QUARTO_VERSION=1.4.554
wget --quiet https://github.com/quarto-dev/quarto-cli/releases/download/v$QUARTO_VERSION/quarto-$QUARTO_VERSION-linux-amd64.deb
/usr/bin/time sudo dpkg -i quarto-$QUARTO_VERSION-linux-amd64.deb \
  >> $LOGFILE 2>&1
popd

echo "Reconfiguring RStudio Server"
./reconfigure_RStudio_Server.sh

echo "Adding $USER to the 'systemd-journal' group"
sudo usermod -a -G systemd-journal $USER

echo ""
echo ""
echo "Notes:"
echo ""
echo "1. To log into RStudio Server, you will need to set a password"
echo "for your username if you're running in a container. Use the script"
echo ""
echo "    ./set_password.sh"
echo ""
echo "to do that."
echo ""
echo "2. By default, RStudio Server listens on IP address 0.0.0.0 port"
echo "8787. If you want to restrict the IP address or change the port,"
echo "edit the file 'rserver.conf' and run"
echo ""
echo "    ./reconfigure_RStudio_Server.sh"
echo ""
echo ""See
echo ""
echo "    https://support.posit.co/hc/en-us/articles/200552316-Configuring-RStudio-Workbench-RStudio-Server"
echo ""
echo "for the details."

echo "Finished!"
