#!/bin/bash

### Project name
#PBS -A UCIR0013

### Job name
#PBS -N real

### Wallclock time
#PBS -l walltime=02:00:00

### Queue
#PBS -q regular

### Merge output and error files
#PBS -j oe

### Select 4 nodes with 36 CPUs, for 144 MPI processes
#PBS -l select=4:ncpus=36:mpiprocs=36

### Email for job info
#PBS -M blangenb@uci.edu

mpiexec_mpt ./real.exe >& log.real


# qhist -u baird
# qsub scriptname

### qsub -I -l select=4:ncpus=36:mpiprocs=36 -l walltime=06:00:00 -q regular -A UCIR0013