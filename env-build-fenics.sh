#!/bin/bash -l
# User should set TAG and FLAGS appropriately
TAG=fenicsx-meluxina-0.6.0-r2
export FLAGS="-O3 -march=znver2"
export MAKEFLAGS="-j16"

PREFIX=/project/scratch/p200165/${TAG}
BUILD_DIR=/tmp/${USER}/${TAG}

module purge

# aion/iris 2020b software set Intel MPI with GCC build
#module load toolchain/iimpi/2020b

# aion/iris 2020b software set OpenMPI with GCC build
#module load toolchain/gompi/2020b

# Meluxina 2022a with OpenMPI
module load gompi/2022a
module load HDF5

module load CMake
module load flex
module load Python
module load OpenBLAS
module load Boost
module load Bison
module load Ninja

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
