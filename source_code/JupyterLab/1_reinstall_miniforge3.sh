#! /bin/bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/1_reinstall_miniforge3.log

echo "Creating a new Miniforge3 installation"
pushd /tmp

  export ARCH=`uname -m`
  rm -fr Miniforge3*
  echo ""
  echo "Downloading latest Miniforge3 installer"
  wget -q \
    https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$ARCH.sh
  chmod +x Miniforge3-Linux-$ARCH.sh

  export MINIFORGE3_HOME=$HOME/miniforge3

  echo "Removing $MINIFORGE3_HOME if it exists"
  if [ -d $MINIFORGE3_HOME ]
  then
    rm -fr $MINIFORGE3_HOME
  fi
  echo "Installing Miniforge3 to $MINIFORGE3_HOME"
  ./Miniforge3-Linux-$ARCH.sh -b -p $MINIFORGE3_HOME \
    >> $LOGFILE 2>&1

popd

echo ""
echo "Enabling 'conda'"
source $MINIFORGE3_HOME/etc/profile.d/conda.sh

echo "Activating 'base'"
conda activate base

echo "Setting default threads to number of processors"
conda config --set default_threads `nproc`

echo "Setting HTTP parameters"
conda config --set remote_connect_timeout_secs 60.0
conda config --set remote_max_retries 20
conda config --set remote_read_timeout_secs 300

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
