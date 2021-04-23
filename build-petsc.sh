#!/bin/bash
set -e
source env-build-fenics.sh

# Can no longer use srun within an interactive session.
# mpiexec with unset I_MPI_PMI_LIBRARY works fine.
# srun within an sbatch script works fine.
unset I_MPI_PMI_LIBRARY

VERSION="3.15.0"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --read-timeout=10 -nc http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${VERSION}.tar.gz -O petsc.tar.gz && \
   mkdir -p ${BUILD_DIR}/petsc && \
   tar -xf petsc.tar.gz -C ${BUILD_DIR}/petsc --strip-components=1 && \
   cd petsc && \
   python3 ./configure \
               --with-blaslapack-dir=${EBROOTIMKL}/mkl \
               --COPTFLAGS="-march=broadwell -O2" \
               --CXXOPTFLAGS="-march=broadwell -O2" \
               --FOPTFLAGS="-march=broadwell -O2" \
               --with-cc=${MPICC} --with-cxx=${MPICXX} --with-fc=${MPIFC} \
               --with-make-np=8 \
               --with-mpiexec="mpiexec" \
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
