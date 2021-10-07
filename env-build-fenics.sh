#!/bin/bash -l
module purge

# 2019b software set Intel MPI with GCC build
#module load devel/CMake/3.15.3-GCCcore-8.3.0
#module load toolchain/iimpi/2019b 
#module load lang/flex/2.6.4-GCCcore-8.3.0
#module load lang/Python/3.7.4-GCCcore-8.3.0
#module load data/HDF5/1.10.5-iimpi-2019b
#module load numlib/imkl/2019.5.281-iimpi-2019b

# 2020b software set Intel MPI with GCC build
module load devel/CMake/3.18.4-GCCcore-10.2.0
module load toolchain/iimpi/2020b 
module load lang/flex/2.6.4-GCCcore-10.2.0
module load lang/Python/3.8.6-GCCcore-10.2.0
module load data/HDF5/1.10.7-iimpi-2020b
module load numlib/OpenBLAS/0.3.12-GCC-10.2.0
module load devel/Boost/1.74.0-GCC-10.2.0
module load lang/Bison/3.7.1-GCCcore-10.2.0

# Using GCC, except for PETSc (Intel compilers).
export CC=gcc
export CXX=g++
export FC=gfortran
export MPICC=mpigcc
export MPICXX=mpigxx
export MPIFC=mpif90

export FLAGS="-O2 -march=znver2"

TAG=aion-master-r13
PREFIX=${HOME}/fenicsx-${TAG}
WORKON_HOME=${PREFIX}/virtualenv
BUILD_DIR=/tmp/${USER}/fenicsx-${TAG}

export PATH=${PREFIX}/bin:${PATH}
export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64:${LD_LIBRARY_PATH}
export C_INCLUDE_PATH=${PREFIX}/include:${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH=${PREFIX}/include:${CPLUS_INCLUDE_PATH}
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig:${PREFIX}/lib64/pkgconfig:$PKG_CONFIG_PATH
