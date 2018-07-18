#!/bin/bash

### Project name
#PBS -A UCIR0013
### Job name
#PBS -N ungrib
### Merge output and error files
#PBS -j oe
### Send email on abort, begin, and end
#PBS -m abe
### Email address
#PBS -M blangenb@uci.edu
### Queue
#PBS -q regular
### Wallclock time
#PBS -l walltime=01:00:00
### Select 2 nodes with 36 CPUs, for 72 MPI processes
#PBS -l select=4:ncpus=36:mpiprocs=36

mpiexec_mpt ./ungrib.exe >& log.ungrib