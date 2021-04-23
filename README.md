# fenicsx-iris-cluster #
### Scripts to build FEniCSX on the University of Luxembourg iris cluster ###

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
$ sbatch build-all.sh
```

FEniCS jobs can be run in interactive mode using:
```
$ si
$$ source env-fenics.sh
$$ srun python3 script_name.py
```
### Advanced ###

You can adjust the build location and the installation location in the file
`env-build-fenics.sh`.

## Running FEniCS MPI jobs ##

Included in this repository is a very simple example launcher script to submit
jobs on the cluster.

```
$ cd $HOME
$ cd fenicsx-iris-cluster
$ sbatch -n 4 fenics-launcher.sh python3 poisson.py
```

## Experimental: LLNL Spindle Support

For large parallel jobs the time taken to load the shared object files from the
cluster can dominate the overall runtime. By default we install the [Spindle
tool](https://github.com/hpc/Spindle/) which seems to effectively deal with
this issue on iris.

If you have issues then please remove the `spindle` prefix to `srun` in the
`fenicsx-launcher.sh` script.
