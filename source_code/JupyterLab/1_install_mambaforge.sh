#! /bin/bash

set -e

echo "Defining LOGFILE"
mkdir --parents Logs
touch Logs/.gitkeep
export LOGFILE=$PWD/Logs/1_install_mambaforge.log

echo "Creating a new Mambaforge installation"

pushd /tmp
export ARCH=`uname -m`
rm -fr Mambaforge*
echo ""
echo "Downloading latest Mambaforge installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-$ARCH.sh
chmod +x Mambaforge-Linux-$ARCH.sh

export MAMBAFORGE_HOME=$HOME/mambaforge

echo "Removing $MAMBAFORGE_HOME if it exists"
if [ -d $MAMBAFORGE_HOME ]
then
  rm -fr $MAMBAFORGE_HOME
fi
echo "Installing Mambaforge to $MAMBAFORGE_HOME"
./Mambaforge-Linux-$ARCH.sh -b -p $MAMBAFORGE_HOME \
  >> $LOGFILE 2>&1

echo ""
echo "Enabling 'conda'"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh

echo "Activating 'base'"
conda activate base

echo "Setting default threads to number of processors"
conda config --set default_threads `nproc`

echo "Updating base packages"
conda update --name base --all --yes --quiet \
  >> $LOGFILE 2>&1

echo "Setting up bash command line"
conda init bash

if [ -e $HOME/.zshrc ]
then
  echo "Setting up zsh command line"
  conda init zsh
fi

echo "Finished!"
