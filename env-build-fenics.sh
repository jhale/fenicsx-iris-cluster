#!/bin/bash -l
# User should set TAG and FLAGS appropriately
TAG=fenicsx-meluxina-0.6.0
export FLAGS="-O3 -march=znver2"
export MAKEFLAGS="-j16"

PREFIX=/project/scratch/p200165/${TAG}
BUILD_DIR=/tmp/${USER}/${TAG}

module purge

# aion/iris 2020b software set Intel MPI with GCC build
#module load toolchain/iimpi/2020b
#module load data/HDF5/1.10.7-iimpi-2020b

# aion/iris 2020b software set OpenMPI with GCC build
#module load toolchain/gompi/2020b
#module load data/HDF5/1.10.7-gompi-2020b

#module load devel/CMake/3.18.4-GCCcore-10.2.0
#module load lang/flex/2.6.4-GCCcore-10.2.0
#module load lang/Python/3.8.6-GCCcore-10.2.0
#module load numlib/OpenBLAS/0.3.12-GCC-10.2.0
#module load devel/Boost/1.74.0-GCC-10.2.0
#module load lang/Bison/3.7.1-GCCcore-10.2.0
#module load tools/Ninja/1.10.1-GCCcore-10.2.0

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
