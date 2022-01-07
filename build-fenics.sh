#!/bin/bash -l
set -e
source env-build-fenics.sh

source ${PREFIX}/python-venv/bin/activate

export PETSC_DIR=${PREFIX}
export PYBIND11_DIR=${PREFIX}

mkdir -p ${BUILD_DIR}

cd ${BUILD_DIR} && \
   git clone --depth 1 https://github.com/fenics/basix.git && \
   cd basix && \
   echo "$(git remote get-url origin) $(git describe --always --tags --dirty)" >> ${PREFIX}/.git-describe && \
   cd cpp && \
   cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} -DDOWNLOAD_XTENSOR_LIBS=ON \
     -B build-dir -S . && \
   cmake --build build-dir && \
   cmake --install build-dir && \
   cd ../python && \
   CXXFLAGS="${FLAGS}" python3 -m pip install --no-dependencies .

cd ${BUILD_DIR} && \
   git clone --depth 1 https://github.com/FEniCS/ufl.git && \
   cd ufl && \
   echo "$(git remote get-url origin) $(git describe --always --tags --dirty)" >> ${PREFIX}/.git-describe && \
   python3 -m pip install --no-dependencies .

cd ${BUILD_DIR} && \
   git clone --depth 1 https://github.com/FEniCS/ffcx.git && \
   cd ffcx && \
   echo "$(git remote get-url origin) $(git describe --always --tags --dirty)" >> ${PREFIX}/.git-describe && \
   python3 -m pip install --no-dependencies .

unset I_MPI_PMI_LIBRARY # Necessary if running in interactive session
cd ${BUILD_DIR} && \
   git clone --depth 1 -b chris/python-no-scotch https://github.com/fenics/dolfinx.git && \
   cd dolfinx && \
   echo "$(git remote get-url origin) $(git describe --always --tags --dirty)" >> ${PREFIX}/.git-describe && \
   cd cpp && \
   cmake -B build-dir -S . \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" -DDOLFINX_SKIP_BUILD_TESTS=ON && \
   cmake --build build-dir && \
   cmake --install build-dir && \
   cd ../python && \
   CXXFLAGS="${FLAGS}" python3 -m pip install --ignore-installed --no-dependencies .
