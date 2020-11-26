#!/bin/bash
source ${HOME}/fenicsx-iris-cluster/env-build-fenics.sh

# Note: These must be unset initially, need to code this in somehow.
export PETSC_DIR=${PREFIX}
mkdir -p ${HOME}/.config/dolfinx
echo '{"cache_dir":"'${PREFIX}/.cache/fenics'", "cffi_extra_compile_args": ["-O3", "-march=native"]}' > ${HOME}/.config/dolfinx/dolfinx_jit_parameters.json

# Bring in virtualenv with python package
source $HOME/.local/bin/virtualenvwrapper.sh
workon fenics-${TAG}

export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
