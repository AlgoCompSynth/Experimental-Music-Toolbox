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

if [ "$CODENAME" == "noble" ]
then

  echo "Adding CRAN repository"
  # https://cran.rstudio.com/bin/linux/ubuntu/

  # update indices
  sudo apt update -qq
  # install two helper packages we need
  sudo apt install -qqy --no-install-recommends software-properties-common dirmngr \
    >> $LOGFILE 2>&1
  # add the signing key (by Michael Rutter) for these repos
  # To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
  # Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
    | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
  # add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
  sudo add-apt-repository --yes \
    "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    >> $LOGFILE 2>&1

elif [ "$CODENAME" == "bookworm" ]
then

  echo "Adding CRAN repository"
  # https://cran.rstudio.com/bin/linux/debian/#secure-apt

  gpg --keyserver keyserver.ubuntu.com \
    --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
  gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | \
    sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc
  sudo cp bookworm.list /etc/apt/sources.list.d/

else
  echo "Unsupported distribution - exiting"
  exit
fi

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

export ARCH=`uname -m`
echo "ARCH: $ARCH"

if [ "$ARCH" != "x86_64" ]
then
  echo ""
  echo "RStudio Server is currently only available for"
  echo "ARCH: x86_64 - exiting. You can still install"
  echo "R packages and use R from the command line"
  echo "and JupyterLab."
  exit
fi

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
