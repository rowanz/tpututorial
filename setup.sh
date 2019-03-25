#!/usr/bin/env bash

curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p ~/conda && \
     rm ~/miniconda.sh && \
     ~/conda/bin/conda install -y python=3.6 tqdm numpy pyyaml scipy ipython mkl mkl-include cython typing h5py pandas && ~/conda/bin/conda clean -ya

echo 'export PATH=~/conda/bin:$PATH' >>~/.bashrc
~/conda/bin/pip install "tensorflow==1.12.0"
~/conda/bin/pip install --upgrade google-api-python-client oauth2client gcsfs