#!/bin/bash
set -e
source env-build-fenics.sh

VERSION="3.14.0"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --read-timeout=10 -nc http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${VERSION}.tar.gz -O petsc.tar.gz && \
   mkdir -p ${BUILD_DIR}/petsc && \
   tar -xf petsc.tar.gz -C ${BUILD_DIR}/petsc --strip-components=1 && \
   cd petsc && \
   python3 ./configure \
               --with-blaslapack-dir=${EBROOTIMKL}/mkl \
               --COPTFLAGS="${FENICSX_OPTFLAGS}" \
               --CXXOPTFLAGS="${FENICSX_OPTFLAGS}" \
               --FOPTFLAGS="${FENICSX_OPTFLAGS}" \
               --with-cc=${MPICC} --with-cxx=${MPICXX} --with-fc=${MPIFC} \
               --with-mpiexec="srun -n 1 --mpi=pmi2" \
               --download-metis \
               --download-ptscotch \
               --download-suitesparse \
               --download-scalapack \
               --download-mumps \
               --with-scalar-type=real \
               --with-debugging=0 \
               --with-shared-libraries \
               --with-fortran-bindings=no \
               --prefix=${PREFIX} && \
    make && \
    make install
