#!/bin/bash
source env-build-fenics.sh

source $HOME/.local/bin/virtualenvwrapper.sh
workon fenicsx-${TAG}

export PETSC_DIR=${PREFIX}
export PYBIND11_DIR=${PREFIX}
export BOOST_ROOT=${PREFIX}

mkdir -p $BUILD_DIR

cd $BUILD_DIR && \
   git clone --depth 1 https://github.com/fenics/basix.git && \
   cd basix && \
   cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="-O2 -march=broadwell" \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} -DBLA_VENDOR="Intel10_64_dyn" -B build-dir -S . && \
   cmake --build build-dir -- -j8 && \
   cmake --install build-dir && \
   CXXFLAGS="-O2 -march=broadwell" python3 -m pip install ./python

python3 -m pip install --no-cache-dir git+https://github.com/FEniCS/ufl.git
python3 -m pip install --no-cache-dir git+https://github.com/FEniCS/ffcx.git

cd $BUILD_DIR && \
   git clone --single-branch --branch jhale/without-std-transform-reduce https://github.com/fenics/dolfinx.git && \
   cd dolfinx && \
   mkdir build && \
   cd build && \
   cmake -DDOLFINX_SKIP_BUILD_TESTS=True -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="-O2 -march=broadwell" \
     -DBLA_VENDOR="Intel10_64_dyn" ../cpp && \
   make -j8 install && \
   cd ../python && \
   CXXFLAGS="-O2 -march=broadwell" python3 -m pip install --ignore-installed --no-dependencies .

mkdir -p ~/.config/dolfinx
echo "{ 'cache_dir': '${SCRATCH}fenicsx-jit-cache', 'cffi_extra_compile_args': '-O3 -march=broadwell' }" > ~/.config/dolfinx/dolfinx_jit_parameters.json 
