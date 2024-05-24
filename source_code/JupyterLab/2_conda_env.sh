#! /bin/bash

set -e

export LOGFILE=Logs/2_conda_env.log

echo "Getting COMPUTE_MODE"
source ../set_compute_mode.sh
echo "COMPUTE_MODE: $COMPUTE_MODE"

echo "Activating 'conda' commands"
source $HOME/mambaforge/etc/profile.d/conda.sh

echo ""
echo "Creating new 'JupyterLab' virtual environment"
/usr/bin/time conda env create --quiet --yes --file conda-env-$COMPUTE_MODE.yml \
  >> $LOGFILE 2>&1

echo "Activating 'JupyterLab' virtual environment"
conda activate JupyterLab

echo "Listing virtual environment to JupyterLab-list.log"
conda list > JupyterLab-list.log

echo "Testing PyTorch and torchaudio"
python ./test-pytorch-$COMPUTE_MODE.py
python ./test-torchaudio.py

echo "Testing for R installation"
if [ -x /usr/bin/Rscript ]
then
  echo "R is installed"
  echo "Installing R package 'caracas'"
  /usr/bin/time Rscript -e "install.packages('caracas', quiet = TRUE)" \
  >> $LOGFILE 2>&1

  echo "Installing R package 'IRkernel'"
  /usr/bin/time Rscript -e "install.packages('IRkernel', quiet = TRUE)" \
  >> $LOGFILE 2>&1

  echo "Installing R kernel"
  Rscript -e "IRkernel::installspec()" \
  >> $LOGFILE 2>&1
else
  echo "R is not installed"
fi

echo "Copying start scripts to $HOME"
cp start_jupyter_lab_*.sh $HOME/

echo "Finished"
