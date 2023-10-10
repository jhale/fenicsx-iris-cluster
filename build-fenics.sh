#!/bin/bash -l
set -e
source env-build-fenics.sh

source ${PREFIX}/python-venv/bin/activate

export PETSC_DIR=${PREFIX}
export PYBIND11_DIR=${PREFIX}

mkdir -p ${BUILD_DIR}

cd ${BUILD_DIR} && \
   git clone -b v0.7.0 --single-branch --depth 1 https://github.com/fenics/basix.git && \
   cd basix/cpp && \
   cmake -G Ninja -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -B build-dir -S . && \
   cmake --build build-dir && \
   cmake --install build-dir && \
   cd ../python && \
   CXXFLAGS="${FLAGS}" python3 -m pip install .

python3 -m pip install -v --no-cache-dir git+https://github.com/FEniCS/ufl.git@2023.2.0
python3 -m pip install -v --no-cache-dir git+https://github.com/FEniCS/ffcx.git@v0.7.0

unset I_MPI_PMI_LIBRARY # Necessary if running in interactive session
cd ${BUILD_DIR} && \
   git clone -b v0.7.0.post0 --single-branch --depth 1 https://github.com/fenics/dolfinx.git && \
   cd dolfinx/cpp && \
   cmake -G Ninja -B build-dir -S . \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_BUILD_TYPE="Release" \
     -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" -DMPIEXEC_EXECUTABLE=srun && \
   cmake --build build-dir && \
   cmake --install build-dir && \
   cd ../python && \
   CXXFLAGS="${FLAGS}" python3 -m pip -v install --ignore-installed --no-dependencies --no-cache-dir .
