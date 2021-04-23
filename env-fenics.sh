#!/bin/bash
source ${HOME}/fenicsx-iris-cluster/env-build-fenics.sh

# Note: These must be unset initially, need to code this in somehow.
export PETSC_DIR=${PREFIX}
export DOLFINX_JIT_CACHE_DIR=${PREFIX}/cache
export DOLFINX_JIT_CFLAGS="-O3 -march=broadwell"

# Bring in virtualenv with python package
source $HOME/.local/bin/virtualenvwrapper.sh
workon fenicsx-${TAG}

export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
