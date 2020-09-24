#!/bin/bash
set -e
source env-build-fenics.sh

VERSION="3.13.3"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --read-timeout=10 -nc http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${VERSION}.tar.gz -O petsc.tar.gz && \
   mkdir -p ${BUILD_DIR}/petsc && \
   tar -xf petsc.tar.gz -C ${BUILD_DIR}/petsc --strip-components=1 && \
   cd petsc && \
   python3 ./configure \
               --with-blaslapack-dir=${EBROOTIMKL}/mkl \
               --COPTFLAGS="-march=native -O2" \
               --CXXOPTFLAGS="-march=native -O2" \
               --FOPTFLAGS="-march=native -O2" \
               --with-cc=mpigcc --with-cxx=mpigxx --with-fc=mpif90 \
               --with-mpiexec="srun -n 1 --mpi=pmi2" \
               --download-metis \
               --download-ptscotch \
               --download-suitesparse \
               --download-scalapack \
               --download-hypre \
               --download-mumps \
               --download-ml \
               --download-superlu \
               --download-superlu_dist \
               --with-scalar-type=real \
               --with-debugging=0 \
               --with-shared-libraries \
               --with-fortran-bindings=no \
               --prefix=${PREFIX} && \
    make && \
    make install
