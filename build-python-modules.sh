#!/bin/bash
source env-build-fenics.sh

export PETSC_DIR=${PREFIX}
export SLEPC_DIR=${PREFIX}

PETSC4PY_VERSION=3.15.0

python3 -m pip install --no-cache-dir virtualenvwrapper

source $HOME/.local/bin/virtualenvwrapper.sh
mkvirtualenv --python=python3 fenicsx-${TAG}
workon fenicsx-${TAG}

python3 -m pip install -v --no-binary numpy numpy 
python3 -m pip install --no-cache-dir cython 
python3 -m pip install --no-cache-dir llvmlite numba
python3 -m pip install -v --no-cache-dir mpi4py petsc4py==${PETSC4PY_VERSION}
