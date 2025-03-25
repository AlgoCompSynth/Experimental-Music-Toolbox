#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/1_R_and_Quarto_CLI.log

echo ""
echo "Installing R"
/usr/bin/time sudo apt-get update \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get upgrade --yes \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install --yes \
  qpdf \
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
echo "Installing Quarto CLI"
pushd /tmp
rm -f *.deb
wget --quiet https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
/usr/bin/time sudo dpkg -i quarto-${QUARTO_VERSION}-linux-amd64.deb \
  >> $LOGFILE 2>&1
popd

echo ""
echo "Finished!"
