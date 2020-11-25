#!/bin/bash
if [[ $(hostname) =~ "iris" ]]; then
    FENICS_CLUSTER="iris"
else
    echo "Do not recognise uni.lu cluster you are running on."
    exit 1
fi

module purge

# Intel MPI with GCC build
module load swenv/default-env
module load devel/CMake/3.13.3-GCCcore-8.2.0
module load toolchain/iimpi/2019a 
module load lang/flex/2.6.4-GCCcore-8.2.0 
module load lang/Python/3.7.2-GCCcore-8.2.0
module load data/HDF5/1.10.5-iimpi-2019a
module load numlib/imkl/2019.1.144-iimpi-2019a
module load math/Eigen/3.3.7
# Required by gmsh binaries
module load vis/libGLU/9.0.0-GCCcore-8.2.0

# Using GCC, except for PETSc (Intel compilers).
export CC=gcc
export CXX=g++
export FC=gfortran
export MPICC=mpigcc
export MPICXX=mpigxx
export MPIFC=mpif90

export FENICSX_OPTFLAGS="-O3 -march=haswell"

# Using Intel Compilers (doesn't work at the moment).
# Note that some components (e.g. Boost) are always built with GCC.
#export CC=icc
#export CXX=icpc
#export FC=ifort
#export MPICC=mpiicc
#export MPICXX=mpiicpc
#export MPIFC=mpiifort

TAG=master-r5
PREFIX=${SCRATCH}/fenicsx-${TAG}
WORKON_HOME=${PREFIX}/virtualenv
BUILD_DIR=/tmp/${USER}/fenicsx-${TAG}
BUILD_THREADS=1

export PATH=${PREFIX}/bin:${PATH}
export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64:${LD_LIBRARY_PATH}
export C_INCLUDE_PATH=${PREFIX}/include:${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH=${PREFIX}/include:${CPLUS_INCLUDE_PATH}
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig:${PREFIX}/lib64/pkgconfig:$PKG_CONFIG_PATH
