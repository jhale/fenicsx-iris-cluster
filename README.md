# fenicsx-iris-cluster #
### Scripts to build FEniCSX on the University of Luxembourg gaia and iris clusters ###

These scripts will automatically build the latest development version of
[FEniCSX](http://fenicsproject.org) with PETSc and HDF5 support on the
University of Luxembourg iris Cluster.
 
To build you need to have an account on and be familiar with using the
University of Luxembourg HPC first, see [HPC uni.lu](http://hpc.uni.lu)

## Compiling instructions ##

Conventions: `$` is a shell on the frontend, `$$` is a shell on a cluster
compute node.

First clone this repository.
```
#!shell
$ cd $HOME
$ git clone https://
$ cd fenicsx-iris-cluster
$ ./builder.sh
```

Run the following commands:
```
#!shell
$$ cd $HOME
$$ cd fenicsx-iris-cluster
$$ ./build-all.sh | tee build.log
```
Wait for the build to finish. The output of the build will be stored in
build.log as well as outputted to the screen.

When you want to run FEniCS you must reserve resources on the cluster and then
setup your environment using:
```
#!shell
$$ source env-fenics.sh
```
before running any scripts.

FEniCS jobs can be run in interactive mode using:
```
#!shell
$$ srun --mpi=pmi2 python3 my_fenics_script.py
```

### Advanced ###

You can adjust the build location and the installation location in the file
`env-build-fenics.sh`.

## Running FEniCS MPI jobs ##

Included in this repository is a very simple example launcher script to submit
jobs on the cluster.

```
#!shell
$ cd $HOME
$ cd fenicsx-iris-cluster
$ sbatch fenics-launcher.sh python3 poisson.py
```

## Known issues

MPI jobs must be launched with `srun`, not `mpirun` or `mpiexec`. Using `mpirun`
or `mpiexec` seems to result in random crashes.
