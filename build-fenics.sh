#!/bin/bash
source env-build-fenics.sh

source $HOME/.local/bin/virtualenvwrapper.sh
workon fenics-${TAG}

export PETSC_DIR=${PREFIX}
export PYBIND11_DIR=${PREFIX}
export EIGEN3_ROOT=${EBROOTEIGEN}/include
export BOOST_ROOT=${PREFIX}

python3 -m pip install --no-cache-dir git+https://github.com/FEniCS/fiat.git
python3 -m pip install --no-cache-dir git+https://github.com/FEniCS/ufl.git
python3 -m pip install --no-cache-dir git+https://github.com/FEniCS/ffcx.git

mkdir -p $BUILD_DIR
cd $BUILD_DIR && \
   git clone --depth 1 https://github.com/fenics/dolfinx.git && \
   cd dolfinx && \
   mkdir build && \
   cd build && \
   cmake -DDOLFINX_SKIP_BUILD_TESTS=True -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FENICSX_OPTFLAGS}" ../cpp && \
   make install && \
   cd ../python && \
   CXXFLAGS="${FENICSX_OPTFLAGS}" python3 -m pip install --ignore-installed --no-dependencies .
