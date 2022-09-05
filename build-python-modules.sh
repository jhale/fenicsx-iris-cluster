#!/bin/bash -l
set -e
source env-build-fenics.sh

export PETSC_DIR=${PREFIX}
export SLEPC_DIR=${PREFIX}

PETSC4PY_VERSION=3.17.4

python3 -m venv ${PREFIX}/python-venv --prompt ${TAG}
source ${PREFIX}/python-venv/bin/activate
python3 -m pip install -v wheel 

python3 -m pip install pybind11
python3 -m pip install --no-binary numpy numpy 
python3 -m pip install --no-cache-dir cython 
python3 -m pip install --no-cache-dir llvmlite numba
python3 -m pip install --no-cache-dir mpi4py petsc4py==${PETSC4PY_VERSION}
