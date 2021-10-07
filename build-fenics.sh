#!/bin/bash
source env-build-fenics.sh

source ${PREFIX}/python-venv/bin/activate

export PETSC_DIR=${PREFIX}
export PYBIND11_DIR=${PREFIX}

mkdir -p $BUILD_DIR

cd $BUILD_DIR && \
   git clone --depth 1 https://github.com/fenics/basix.git && \
   cd basix && \
   cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -B build-dir -S . && \
   cmake --build build-dir -- -j8 && \
   cmake --install build-dir && \
   CXXFLAGS="${FLAGS}" python3 -m pip install ./python

python3 -m pip install --no-cache-dir git+https://github.com/FEniCS/ufl.git
python3 -m pip install --no-cache-dir git+https://github.com/FEniCS/ffcx.git

cd $BUILD_DIR && \
   git clone https://github.com/fenics/dolfinx.git && \
   cd dolfinx/cpp && \
   cmake -B build-dir -S . -DDOLFINX_SKIP_BUILD_TESTS=True -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" && \
   cmake --build build-dir -- -j8 && \
   cmake --install build-dir && \
   cd ../python && \
   CXXFLAGS="${FLAGS}" python3 -m pip install --ignore-installed --no-dependencies .

mkdir -p ~/.config/dolfinx
echo "{ 'cache_dir': '${SCRATCH}fenicsx-jit-cache', 'cffi_extra_compile_args': '${FLAGS}' }" > ~/.config/dolfinx/dolfinx_jit_parameters.json 
