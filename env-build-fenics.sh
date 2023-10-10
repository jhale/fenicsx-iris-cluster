#!/bin/bash -l
# User should set TAG and FLAGS appropriately
TAG=fenicsx-iris-intel-32-0.7.0
export FLAGS="-O3 -march=broadwell"
export MAKEFLAGS="-j16"

PREFIX=${SCRATCH}/${TAG}
BUILD_DIR=/tmp/${USER}/${TAG}

module purge

# 2020b software set Intel MPI with GCC build
#module load toolchain/iimpi

# 2020b software set OpenMPI with GCC build
module load toolchain/gompi
module load data/HDF5

module load devel/CMake
module load lang/flex
module load lang/Python
module load numlib/OpenBLAS
module load devel/Boost
module load lang/Bison
module load tools/Ninja

# Use GCC for non-MPI builds.
export CC=gcc
export CXX=g++
export FC=gfortran

# 2020b software set OpenMPI with GCC
export MPICC=mpicc
export MPICXX=mpicxx
export MPIFC=mpif90

# 2020b software set Intel MPI with GCC
#export MPICC=mpigcc
#export MPICXX=mpigxx
#export MPIFC=mpif90

export PATH=${PREFIX}/bin:${PATH}
export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64:${LD_LIBRARY_PATH}
export C_INCLUDE_PATH=${PREFIX}/include:${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH=${PREFIX}/include:${CPLUS_INCLUDE_PATH}
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig:${PREFIX}/lib64/pkgconfig:$PKG_CONFIG_PATH
