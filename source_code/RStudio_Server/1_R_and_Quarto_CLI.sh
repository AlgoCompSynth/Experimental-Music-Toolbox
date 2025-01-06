#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/1_R_and_Quarto_CLI.log

echo "Adding CRAN repository"
# https://cran.rstudio.com/bin/linux/ubuntu/

# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
  | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository --yes \
  "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
  >> $LOGFILE 2>&1

echo ""
echo "Installing R"
/usr/bin/time sudo apt-get update \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get upgrade --yes \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install --yes \
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
