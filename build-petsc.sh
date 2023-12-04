#!/bin/bash -l
set -e
source env-build-fenics.sh

VERSION="v3.20.2"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   git clone -b ${VERSION} https://gitlab.com/petsc/petsc.git petsc && \
   mkdir -p ${BUILD_DIR}/petsc && \
   cd petsc && \
   python3 ./configure \
     --with-blaslapack-dir=${EBROOTOPENBLAS}/lib \
     --COPTFLAGS="${FLAGS}" \
     --CXXOPTFLAGS="${FLAGS}" \
     --FOPTFLAGS="${FLAGS}" \
     --with-cc=${MPICC} --with-cxx=${MPICXX} --with-fc=${MPIFC} \
     --with-make-np=16 \
     --with-mpiexec="srun" \
     --download-metis \
     --download-parmetis \
     --download-scalapack \
     --download-hypre \
     --download-mumps \
     --with-scalar-type=real \
     --with-debugging=0 \
     --with-shared-libraries \
     --with-fortran-bindings=no \
     --with-64-bit-indices=no \
     --prefix=${PREFIX} && \
    make && \
    make install
